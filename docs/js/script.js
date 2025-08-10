// Navigation functionality
document.addEventListener('DOMContentLoaded', function() {
    // Navigation
    const navLinks = document.querySelectorAll('.nav-link');
    const sections = document.querySelectorAll('.section');

    // Function to show section
    function showSection(sectionId) {
        // Hide all sections
        sections.forEach(section => {
            section.classList.remove('active');
        });

        // Show target section
        const targetSection = document.getElementById(sectionId);
        if (targetSection) {
            targetSection.classList.add('active');
        }

        // Update navigation
        navLinks.forEach(link => {
            link.classList.remove('active');
        });

        const activeLink = document.querySelector(`[href="#${sectionId}"]`);
        if (activeLink) {
            activeLink.classList.add('active');
        }
    }

    // Navigation click handlers
    navLinks.forEach(link => {
        link.addEventListener('click', function(e) {
            e.preventDefault();
            const sectionId = this.getAttribute('href').substring(1);
            showSection(sectionId);
            
            // Update URL without page reload
            history.pushState(null, null, `#${sectionId}`);
        });
    });

    // Handle browser back/forward buttons
    window.addEventListener('popstate', function() {
        const hash = window.location.hash.substring(1) || 'overview';
        showSection(hash);
    });

    // Show initial section based on URL hash
    const initialHash = window.location.hash.substring(1) || 'overview';
    showSection(initialHash);

    // Keybinding tabs functionality
    const tabBtns = document.querySelectorAll('.tab-btn');
    const categoryPanels = document.querySelectorAll('.category-panel');

    tabBtns.forEach(btn => {
        btn.addEventListener('click', function() {
            const category = this.getAttribute('data-category');
            
            // Remove active class from all buttons and panels
            tabBtns.forEach(b => b.classList.remove('active'));
            categoryPanels.forEach(panel => panel.classList.remove('active'));
            
            // Add active class to clicked button and corresponding panel
            this.classList.add('active');
            const targetPanel = document.getElementById(category);
            if (targetPanel) {
                targetPanel.classList.add('active');
            }
        });
    });

    // Copy code functionality
    function copyCode(button) {
        const codeBlock = button.closest('.code-block');
        const code = codeBlock.querySelector('code').textContent;
        
        // Create temporary textarea to copy text
        const textarea = document.createElement('textarea');
        textarea.value = code;
        document.body.appendChild(textarea);
        textarea.select();
        
        try {
            document.execCommand('copy');
            
            // Show success feedback
            const originalIcon = button.innerHTML;
            button.innerHTML = '<i class="fas fa-check"></i>';
            button.style.color = '#48BB78';
            
            setTimeout(() => {
                button.innerHTML = originalIcon;
                button.style.color = '';
            }, 2000);
        } catch (err) {
            console.error('Failed to copy code:', err);
            
            // Show error feedback
            const originalIcon = button.innerHTML;
            button.innerHTML = '<i class="fas fa-times"></i>';
            button.style.color = '#F56565';
            
            setTimeout(() => {
                button.innerHTML = originalIcon;
                button.style.color = '';
            }, 2000);
        }
        
        document.body.removeChild(textarea);
    }

    // Make copyCode function globally available
    window.copyCode = copyCode;

    // Smooth scrolling for anchor links
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            const target = document.querySelector(this.getAttribute('href'));
            if (target) {
                target.scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
            }
        });
    });

    // Keybinding search removed per request; UI now relies on category tabs only

    // Theme toggle functionality
    function createThemeToggle() {
        const sidebar = document.querySelector('.sidebar');
        if (!sidebar) return;

        const themeToggle = document.createElement('div');
        themeToggle.className = 'theme-toggle';
        themeToggle.innerHTML = `
            <button id="theme-toggle-btn" title="Toggle theme">
                <i class="fas fa-moon"></i>
            </button>
        `;

        sidebar.appendChild(themeToggle);

        // Add theme toggle styles
        const style = document.createElement('style');
        style.textContent = `
            .theme-toggle {
                position: absolute;
                bottom: 2rem;
                left: 1.5rem;
                right: 1.5rem;
            }
            .theme-toggle button {
                width: 100%;
                padding: 0.75rem;
                background-color: var(--surface-color);
                border: 1px solid var(--border-color);
                border-radius: var(--border-radius);
                color: var(--text-secondary);
                cursor: pointer;
                transition: var(--transition);
                display: flex;
                align-items: center;
                justify-content: center;
            }
            .theme-toggle button:hover {
                background-color: rgba(108, 198, 68, 0.1);
                color: var(--primary-color);
                border-color: var(--primary-color);
            }
            body.light-theme {
                --background-color: #F7FAFC;
                --surface-color: #FFFFFF;
                --text-primary: #2D3748;
                --text-secondary: #4A5568;
                --border-color: #E2E8F0;
                --code-bg: #F7FAFC;
            }
        `;
        document.head.appendChild(style);

        // Theme toggle functionality
        const themeBtn = document.getElementById('theme-toggle-btn');
        const isDark = localStorage.getItem('theme') !== 'light';
        
        function setTheme(isDark) {
            if (isDark) {
                document.body.classList.remove('light-theme');
                themeBtn.innerHTML = '<i class="fas fa-moon"></i>';
                localStorage.setItem('theme', 'dark');
            } else {
                document.body.classList.add('light-theme');
                themeBtn.innerHTML = '<i class="fas fa-sun"></i>';
                localStorage.setItem('theme', 'light');
            }
        }

        // Set initial theme
        setTheme(isDark);

        themeBtn.addEventListener('click', function() {
            const isCurrentlyDark = !document.body.classList.contains('light-theme');
            setTheme(!isCurrentlyDark);
        });
    }

    createThemeToggle();

    // Mobile menu toggle
    function createMobileMenu() {
        const content = document.querySelector('.content');
        if (!content) return;

        const mobileToggle = document.createElement('button');
        mobileToggle.className = 'mobile-menu-toggle';
        mobileToggle.innerHTML = '<i class="fas fa-bars"></i>';
        mobileToggle.setAttribute('aria-label', 'Toggle menu');

        content.insertBefore(mobileToggle, content.firstChild);

        // Add mobile menu styles
        const style = document.createElement('style');
        style.textContent = `
            .mobile-menu-toggle {
                position: fixed;
                top: 1rem;
                left: 1rem;
                z-index: 1001;
                background-color: var(--primary-color);
                color: white;
                border: none;
                border-radius: 50%;
                width: 50px;
                height: 50px;
                cursor: pointer;
                display: none;
                align-items: center;
                justify-content: center;
                font-size: 1.2rem;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
                transition: var(--transition);
            }
            .mobile-menu-toggle:hover {
                transform: scale(1.1);
            }
            @media (max-width: 768px) {
                .mobile-menu-toggle {
                    display: flex;
                }
                .sidebar {
                    transform: translateX(-100%);
                }
                .sidebar.open {
                    transform: translateX(0);
                }
            }
        `;
        document.head.appendChild(style);

        // Mobile menu functionality
        const sidebar = document.querySelector('.sidebar');
        
        mobileToggle.addEventListener('click', function() {
            sidebar.classList.toggle('open');
        });

        // Close sidebar when clicking outside on mobile
        document.addEventListener('click', function(e) {
            if (window.innerWidth <= 768) {
                if (!sidebar.contains(e.target) && !mobileToggle.contains(e.target)) {
                    sidebar.classList.remove('open');
                }
            }
        });
    }

    createMobileMenu();

    // Intersection Observer for animations
    const observerOptions = {
        threshold: 0.1,
        rootMargin: '0px 0px -50px 0px'
    };

    const observer = new IntersectionObserver(function(entries) {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.style.opacity = '1';
                entry.target.style.transform = 'translateY(0)';
            }
        });
    }, observerOptions);

    // Observe elements for animation
    document.querySelectorAll('.feature-card, .plugin-card, .trouble-card, .stat-card').forEach(el => {
        el.style.opacity = '0';
        el.style.transform = 'translateY(20px)';
        el.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
        observer.observe(el);
    });

    // Log successful load
    console.log('Neovim Configuration Documentation loaded successfully!');
    console.log('Keyboard shortcuts: Ctrl/Cmd + 1-8 for navigation');
    console.log('Theme: Dark/Light mode toggle available in sidebar');
});

// Tab functionality for keybinding categories
document.addEventListener('DOMContentLoaded', function() {
    const tabBtns = document.querySelectorAll('.tab-btn');
    const categoryPanels = document.querySelectorAll('.category-panel');

    tabBtns.forEach(btn => {
        btn.addEventListener('click', () => {
            const targetCategory = btn.getAttribute('data-category');
            
            // Remove active class from all tabs and panels
            tabBtns.forEach(b => b.classList.remove('active'));
            categoryPanels.forEach(panel => panel.classList.remove('active'));
            
            // Add active class to clicked tab and corresponding panel
            btn.classList.add('active');
            document.getElementById(targetCategory).classList.add('active');
        });
    });
});

// Mobile menu functionality
document.addEventListener('DOMContentLoaded', function() {
    const mobileMenuBtn = document.querySelector('.mobile-menu-btn');
    const mobileMenu = document.querySelector('.mobile-menu');
    const mobileMenuClose = document.querySelector('.mobile-menu-close');

    if (mobileMenuBtn && mobileMenu) {
        mobileMenuBtn.addEventListener('click', () => {
            mobileMenu.classList.add('active');
        });

        if (mobileMenuClose) {
            mobileMenuClose.addEventListener('click', () => {
                mobileMenu.classList.remove('active');
            });
        }
    }
});

// (search removed)

// Smooth scrolling for navigation links
document.addEventListener('DOMContentLoaded', function() {
    const navLinks = document.querySelectorAll('a[href^="#"]');
    
    navLinks.forEach(link => {
        link.addEventListener('click', (e) => {
            e.preventDefault();
            const targetId = link.getAttribute('href');
            const targetSection = document.querySelector(targetId);
            
            if (targetSection) {
                targetSection.scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
            }
        });
    });
});

// Keyboard shortcuts
document.addEventListener('keydown', function(e) {
    // Ctrl/Cmd + number keys for navigation
    if ((e.ctrlKey || e.metaKey) && e.key >= '1' && e.key <= '8') {
        e.preventDefault();
        const sectionMap = {
            '1': 'overview',
            '2': 'features',
            '3': 'installation',
            '4': 'keybinding-system',
            '5': 'keybindings',
            '6': 'plugins',
            '7': 'customization',
            '8': 'troubleshooting'
        };
        
        const targetSection = sectionMap[e.key];
        if (targetSection) {
            const section = document.getElementById(targetSection);
            if (section) {
                section.scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
            }
        }
    }
    
    // Escape key to close mobile menu
    if (e.key === 'Escape') {
        const mobileMenu = document.querySelector('.mobile-menu');
        
        if (mobileMenu && mobileMenu.classList.contains('active')) {
            mobileMenu.classList.remove('active');
        }
    }
});

// Console log for keyboard shortcuts
console.log('Keyboard shortcuts: Ctrl/Cmd + 1-8 for navigation');
console.log('Escape: Close mobile menu');
console.log('Tab: Navigate through interactive elements');
console.log('Enter: Activate buttons and links');
