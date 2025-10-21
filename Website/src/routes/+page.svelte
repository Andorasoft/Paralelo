

<style>
    :global(body) {
        margin: 0;
        font-family: 'Inter', sans-serif;
        background-color: #FBF8FF;
        color: #374151;
    }

    header {
        position: sticky;
        top: 0;
        z-index: 10;
        background-color: rgba(255, 255, 255, 0.8);
        backdrop-filter: blur(6px);
        border-bottom: 1px solid #E5E7EB;
    }

    header h1 {
        color: #1E40AF;
        font-weight: 700;
        font-size: 1.75rem;
        margin: 0;
        padding: 1rem 2rem;
    }

    main {
        display: flex;
        flex-direction: column;
        gap: 4rem;
    }

    .container {
        width: 90%;
        max-width: 1200px;
        margin: 0 auto;
    }

    /* HERO SECTION */
    .hero {
        display: flex;
        flex-direction: column;
        align-items: center;
        gap: 2rem;
        padding: 4rem 1rem;
    }

    .hero-content {
        max-width: 480px;
        text-align: left;
    }

    .hero h1 {
        font-size: 3rem;
        font-weight: 900;
        color: #1E40AF;
        margin-bottom: 1rem;
    }

    .hero h2 {
        font-size: 1.125rem;
        color: #4B5563;
        margin-bottom: 1.5rem;
    }

    .hero button {
        background-color: #3B82F6;
        color: #fff;
        border: none;
        padding: 0.75rem 1.5rem;
        border-radius: 0.75rem;
        font-weight: bold;
        cursor: pointer;
        transition: background-color 0.3s;
    }

    .hero button:hover {
        background-color: #2563EB;
    }

    .hero img {
        width: 100%;
        max-width: 600px;
        border-radius: 1rem;
        object-fit: cover;
    }

    /* SECTION TITLES */
    section {
        text-align: center;
        padding: 4rem 1rem;
    }

    section h2 {
        font-size: 2rem;
        font-weight: 700;
        color: #1E40AF;
        margin-bottom: 1rem;
    }

    section p {
        color: #4B5563;
        max-width: 600px;
        margin: 0 auto 2rem;
    }

    /* CARDS GRID */
    .grid {
        display: grid;
        gap: 1.5rem;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        max-width: 900px;
        margin: 0 auto;
    }

    .card {
        background: white;
        border: 1px solid #E5E7EB;
        border-radius: 1rem;
        padding: 1.5rem;
        box-shadow: 0 1px 3px rgba(0,0,0,0.05);
        text-align: center;
    }

    .card h3 {
        color: #1E40AF;
        font-size: 1.125rem;
        font-weight: 700;
    }

    .card p {
        font-size: 0.9rem;
        color: #6B7280;
    }

    /* STATS */
    .stats {
        display: flex;
        flex-wrap: wrap;
        justify-content: center;
        gap: 1rem;
        margin-top: 2rem;
    }

    .stat {
        min-width: 180px;
        background: white;
        border: 1px solid #E5E7EB;
        border-radius: 1rem;
        padding: 1.5rem;
        text-align: center;
    }

    .stat p:first-child {
        font-size: 2rem;
        font-weight: 700;
        color: #1E40AF;
    }

    /* FOOTER */
    footer {
        background: #F9FAFB;
        padding: 3rem 1rem;
        text-align: center;
    }

    footer h3 {
        color: #1E40AF;
        font-size: 1.25rem;
        font-weight: 700;
    }

    footer a {
        color: #4B5563;
        margin: 0 1rem;
        text-decoration: none;
        transition: color 0.3s;
    }

    footer a:hover {
        color: #3B82F6;
    }

    footer p {
        font-size: 0.9rem;
        color: #6B7280;
        margin-top: 1rem;
    }
</style>

<header>
    <h1>Paralelo</h1>
</header>

<main>
    <!-- HERO -->
    <section class="hero container">
        <div class="hero-content">
            <h1>Your Academic Parallel.</h1>
            <h2>Connecting students for academic support.</h2>
            <button>Join the academic network</button>
        </div>
        <img src="https://lh3.googleusercontent.com/aida-public/AB6AXuASr5L2S7os4yzaptGEwQ4bsjkn3lBHxhI0W7yX2N1Qg_lW8E7_09-TT-I3AV_1Dmr_nGJqC4d38hPLdb3uaCX0A5EmAfz_LMSiaFfBBS1LWHXHQm7qhxncLJ1zm2bht1o4lQX6LiPJuTupXgsYVn7-cz_FBIGEn9PwSoE7__iJxJQ22Jw5cnBBYNw1Orx7WKA68AEn6UYvz_LpWIy3lkTa8nDCOfRxoo5gykE1Hwu462fQBd1incRXEl7cWGs2SotFLVAWhUy-rEY" alt="Paralelo abstract illustration"/>
    </section>

    <!-- HOW IT WORKS -->
    <section>
        <h2>How Paralelo Works</h2>
        <p>Briefly explaining how users can offer or request academic help.</p>
        <div class="grid">
            <div class="card">
                <h3>Offer Services</h3>
                <p>Share your knowledge and help peers grow.</p>
            </div>
            <div class="card">
                <h3>Request Help</h3>
                <p>Get academic assistance from trusted students.</p>
            </div>
        </div>
    </section>

    <!-- WHY CHOOSE -->
    <section>
        <h2>Why Choose Paralelo?</h2>
        <p>Explore the features that make our platform unique.</p>
        <div class="grid">
            <div class="card">
                <h3>Dynamic Roles</h3>
                <p>Easily switch between offering and requesting services.</p>
            </div>
            <div class="card">
                <h3>Real-time Chat</h3>
                <p>Communicate instantly with your academic partners.</p>
            </div>
            <div class="card">
                <h3>Reputation System</h3>
                <p>Build trust with a reliable review and rating system.</p>
            </div>
            <div class="card">
                <h3>Safe Collaboration</h3>
                <p>A secure environment for all your academic needs.</p>
            </div>
        </div>
    </section>

    <!-- STATS -->
    <section>
        <div class="stats">
            <div class="stat">
                <p>100+</p>
                <p>Users</p>
            </div>
            <div class="stat">
                <p>50+</p>
                <p>Services</p>
            </div>
            <div class="stat">
                <p>70%</p>
                <p>Satisfaction</p>
            </div>
        </div>
    </section>
</main>

<footer>
    <h3>Paralelo</h3>
    <p>contact@paralelo.app</p>
    <div>
        <a href="#">Contact</a>
        <a href="#">About</a>
        <a href="#">Terms of Service</a>
    </div>
    <p>© 2025 Paralelo</p>
</footer>
