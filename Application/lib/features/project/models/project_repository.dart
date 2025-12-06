import 'package:paralelo/core/imports.dart';
import './project.dart';

abstract class ProjectRepository {
  Future<(int, List<Project>)> getPaginated({
    required String excludedUserId,
    String? universityId,
    String? query,
    int page = 1,
    int limit = 10,
  });

  Future<Project?> getById(String id);

  Future<List<Project>> getByIds(List<String> ids);

  Future<List<Project>> getForUser(String userId);

  Future<Project> create({
    required String title,
    required String description,
    required String requirement,
    bool? featured,
    required String ownerId,
    required String categoryId,
  });

  Future<Project?> update(
    String id, {
    String? title,
    String? description,
    String? requirement,
    bool? featured,
    String? categoryId,
  });

  Future<void> delete(String id);

  Future<int> countActive(String ownerId);

  Future<int> countFeatured(String ownerId);
}

class SupabaseProjectRepository implements ProjectRepository {
  final SupabaseClient _client;

  const SupabaseProjectRepository(this._client);

  @override
  Future<(int, List<Project>)> getPaginated({
    required String excludedUserId,
    String? universityId,
    String? query,
    int page = 1,
    int limit = 10,
  }) async {
    final start = (page - 1) * limit;
    final end = start + limit - 1;

    // 1) Si llega universityId → buscamos los user.id de esa universidad
    List<String>? allowedOwnerIds;
    if (universityId != null) {
      final usersRes = await _client
          .from('user')
          .select('id')
          .eq('university_id', universityId);

      final usersList = (usersRes as List);
      if (usersList.isEmpty) {
        return (0, <Project>[]);
      }
      allowedOwnerIds = usersList.map((u) => u['id'] as String).toList();
    }

    // 2) Filtro de búsqueda por texto
    String? orSearch;
    if (query != null && query.trim().isNotEmpty) {
      final q = query.trim();
      final pattern = '%$q%';

      orSearch = 'title.ilike.$pattern';
      //'title.ilike.$pattern,description.ilike.$pattern,requirement.ilike.$pattern';
    }

    // ---------- COUNT ----------
    var countQuery = _client
        .from('project')
        .select('id')
        .neq('owner_id', excludedUserId);

    if (allowedOwnerIds != null) {
      countQuery = countQuery.inFilter('owner_id', allowedOwnerIds);
    }
    if (orSearch != null) {
      countQuery = countQuery.or(orSearch);
    }

    final countRes = await countQuery;
    final total = (countRes as List).length;
    final pages = (total / limit).ceil();

    if (total == 0) return (0, <Project>[]);

    // ---------- DATA ----------
    var dataQuery = _client
        .from('project')
        .select()
        .neq('owner_id', excludedUserId);

    if (allowedOwnerIds != null) {
      dataQuery = dataQuery.inFilter('owner_id', allowedOwnerIds);
    }
    if (orSearch != null) {
      dataQuery = dataQuery.or(orSearch);
    }

    final data = await dataQuery
        .order('created_at', ascending: false)
        .range(start, end);

    final projects = data.map((i) => Project.fromMap(i)).toList();

    return (pages, projects);
  }

  @override
  Future<Project?> getById(String id) async {
    final data = await _client
        .from('project')
        .select()
        .eq('id', id)
        .maybeSingle();

    return data != null ? Project.fromMap(data) : null;
  }

  @override
  Future<List<Project>> getByIds(List<String> ids) async {
    final data = await _client
        .from('project')
        .select()
        .filter('id', 'in', '(${ids.join(',')})');

    return data.map((i) => Project.fromMap(i)).toList();
  }

  @override
  Future<List<Project>> getForUser(String userId) async {
    final data = await _client.from('project').select().eq('owner_id', userId);

    return data.map((i) => Project.fromMap(i)).toList();
  }

  @override
  Future<Project> create({
    required String title,
    required String description,
    required String requirement,
    bool? featured,
    required String ownerId,
    required String categoryId,
  }) async {
    final data = await _client
        .from('project')
        .insert({
          'title': title,
          'description': description,
          'requirement': requirement,
          'featured': featured ?? false,
          'category_id': categoryId,
          'owner_id': ownerId,
        })
        .select()
        .single();

    return Project.fromMap(data);
  }

  @override
  Future<Project?> update(
    String id, {
    String? title,
    String? description,
    String? requirement,
    bool? featured,
    String? categoryId,
  }) async {
    final updates = <String, dynamic>{};

    if (title != null) {
      updates['title'] = title;
    }
    if (description != null) {
      updates['description'] = description;
    }
    if (requirement != null) {
      updates['requirement'] = requirement;
    }
    if (featured != null) {
      updates['featured'] = featured;
    }
    if (categoryId != null) {
      updates['category_id'] = categoryId;
    }

    if (updates.isEmpty) return await getById(id);

    final data = await _client
        .from('project')
        .update(updates)
        .eq('id', id)
        .select()
        .maybeSingle();

    return data != null ? Project.fromMap(data) : null;
  }

  @override
  Future<void> delete(String id) async {
    await _client.from('project').delete().eq('id', id);
  }

  @override
  Future<int> countActive(String ownerId) async {
    final data = await _client
        .from('project')
        .select('id')
        .eq('owner_id', ownerId)
        .or('status.eq.OPEN,status.eq.IN_PROGRESS');

    return data.length;
  }

  @override
  Future<int> countFeatured(String ownerId) async {
    final data = await _client
        .from('project')
        .select('id')
        .eq('owner_id', ownerId)
        .eq('featured', true);

    return data.length;
  }
}
