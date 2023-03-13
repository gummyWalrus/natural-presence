<div class="navbar">
    <div class="navbar-item hover:text-green-400">
        <a href="{import.meta.env.VITE_HOME_URL}">
            Home
        </a>
    </div>
    <div class="navbar-item hover:text-green-400">
        <a href="{import.meta.env.VITE_CV_URL}">
            CV
        </a>
    </div>
    <div class="navbar-item hover:text-green-400">
        <a href="{import.meta.env.VITE_BLOG_URL}">
            Blog
        </a>
    </div>
</div>

<style scoped>
    .navbar {
        position: sticky;
        top: 0;
        left: 0;
        width: 100%;
        height: 64px;
        background-color: #374151;
        display: flex;
        flex-direction: row; 
        font-size: 1.25rem;
        justify-content: flex-start;
        background-color: rgb(0, 0, 0, 0.97);
        padding-left: 64px;
    }
    .navbar-item {
        padding-left: 3rem;
        padding-right: 3rem;
        padding-top: 1rem;
    }
    .navbar-item:last-child {
        border: none !important;
    }
    .navbar-item {
        border-right: 1px solid white;
    }
</style>