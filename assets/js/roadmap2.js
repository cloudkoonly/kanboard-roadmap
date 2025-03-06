/*const roadmapData = {
    'in-review': [
        {
            id: 1,
            title: 'Enhanced Code Completion',
            description: 'Next-generation code completion powered by advanced AI models, providing context-aware suggestions and intelligent code snippets.',
            launchDate: '2025-01-15',
            progress: 85,
            likes: 145,
            tags: ['AI', 'Developer Experience', 'Productivity'],
            assignee: 'Sarah Chen',
            priority: 'High',
            comments: [
                { author: 'John', date: '2024-12-25', text: 'The preview version is already showing impressive results!' },
                { author: 'Emma', date: '2024-12-28', text: 'Can\'t wait for the TypeScript improvements.' }
            ]
        },
        {
            id: 2,
            title: 'Performance Optimization Suite',
            description: 'Comprehensive suite of tools for analyzing and optimizing code performance, including memory profiling and runtime analysis.',
            launchDate: '2025-02-01',
            progress: 70,
            likes: 98,
            tags: ['Performance', 'Developer Tools'],
            assignee: 'Michael Ross',
            priority: 'Medium',
            comments: []
        }
    ],
    'planned': [
        {
            id: 3,
            title: 'Advanced Git Integration',
            description: 'Enhanced Git workflow with visual diff viewer, conflict resolution assistant, and AI-powered commit message suggestions.',
            launchDate: '2025-03-15',
            progress: 0,
            likes: 167,
            tags: ['Git', 'Collaboration', 'AI'],
            assignee: 'Alex Thompson',
            priority: 'High',
            comments: [
                { author: 'Lisa', date: '2024-12-29', text: 'The visual diff viewer mock-ups look amazing!' }
            ]
        },
        {
            id: 4,
            title: 'Cross-Platform Sync',
            description: 'Seamless synchronization of settings, snippets, and extensions across different devices and platforms.',
            launchDate: '2025-04-01',
            progress: 0,
            likes: 134,
            tags: ['Sync', 'Cloud'],
            assignee: 'David Kim',
            priority: 'Medium',
            comments: []
        }
    ],
    'in-progress': [
        {
            id: 5,
            title: 'Real-time Collaboration',
            description: 'Code together in real-time with team members, featuring cursor presence, live editing, and integrated voice chat.',
            launchDate: '2025-01-30',
            progress: 60,
            likes: 223,
            tags: ['Collaboration', 'Teams'],
            assignee: 'Rachel Green',
            priority: 'Critical',
            comments: [
                { author: 'Tom', date: '2024-12-27', text: 'The beta version is working great for our team!' }
            ]
        },
        {
            id: 6,
            title: 'AI Code Review Assistant',
            description: 'Automated code review system that provides intelligent suggestions for code quality, security, and best practices.',
            launchDate: '2025-02-15',
            progress: 45,
            likes: 189,
            tags: ['AI', 'Code Quality'],
            assignee: 'James Wilson',
            priority: 'High',
            comments: []
        }
    ],
    'complete': [
        {
            id: 7,
            title: 'Dark Theme Pro',
            description: 'Professional dark theme with customizable accent colors and improved contrast for better readability.',
            launchDate: '2024-12-20',
            progress: 100,
            likes: 278,
            tags: ['UI', 'Customization'],
            assignee: 'Emily Brown',
            priority: 'Completed',
            comments: [
                { author: 'Mark', date: '2024-12-22', text: 'The new theme is absolutely gorgeous!' },
                { author: 'Sarah', date: '2024-12-24', text: 'Love the customizable accent colors.' }
            ]
        },
        {
            id: 8,
            title: 'Integrated Terminal 2.0',
            description: 'Enhanced terminal with split views, improved performance, and better integration with development workflows.',
            launchDate: '2024-12-15',
            progress: 100,
            likes: 245,
            tags: ['Terminal', 'Developer Tools'],
            assignee: 'Chris Martinez',
            priority: 'Completed',
            comments: []
        }
    ]
};*/
let roadmapData = [];
// Roadmap Application
const RoadmapApp = {
    // Configuration
    config: {
        animationDuration: 300,
        maxDescriptionLength: 100,
        autoSaveDelay: 1000,
        itemsPerPage: 10
    },

    // State
    state: {
        currentSort: 'date', // 'date' or 'likes'
        currentFilter: '',
        lastSaved: null,
        isDirty: false
    },

    // Cache DOM elements
    elements: {
        modal: null,
        columns: {},
        commentForm: null
    },

    // Initialize the application
    init() {
        this.loadData();
        this.cacheElements();
        this.bindEvents();
    },

    // Cache frequently used DOM elements
    cacheElements() {
        this.elements.modal = new bootstrap.Modal(document.getElementById('itemDetailModal'));
        this.elements.commentForm = document.querySelector('.add-comment');
        
        // Cache column elements
        ['in-review', 'planned', 'in-progress', 'complete'].forEach(columnId => {
            this.elements.columns[columnId] = document.getElementById(columnId);
        });
    },

    // Bind event listeners
    bindEvents() {
        // Column sorting
        document.querySelectorAll('.roadmap-items').forEach(column => {
            const sortBtn = column.parentElement.querySelector('.sort-btn');
            if (sortBtn) {
                sortBtn.addEventListener('click', () => this.sortItems(column.id));
            }
        });

        // Comment form submission
        this.elements.commentForm.querySelector('button').addEventListener('click', 
            () => this.handleCommentSubmission());

        // Like button delegation
        document.addEventListener('click', (e) => {
            if (e.target.closest('.like-button')) {
                const itemId = e.target.closest('.roadmap-item').dataset.itemId;
                this.handleLike(e, parseInt(itemId));
            }
        });

        // Item click delegation
        document.addEventListener('click', (e) => {
            const item = e.target.closest('.roadmap-item');
            if (item && !e.target.closest('.like-button')) {
                this.showItemDetails(parseInt(item.dataset.itemId));
            }
        });

        // Search functionality
        const searchInput = document.querySelector('.search-input');
        if (searchInput) {
            searchInput.addEventListener('input', this.debounce((e) => {
                this.handleSearch(e.target.value);
            }, 300));
        }
    },

    // Load and render initial data
    loadData() {
        fetch('/roadmap')
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.json();
            })
            .then(data => {
                if (data.status === 'ok') {
                    roadmapData = data.data;
                    this.renderAllColumns();
                    console.log('Data fetched successfully:', roadmapData);
                } else {
                    console.error('API returned an error:', data.message);
                }
            })
            .catch(error => {
                console.error('Error fetching data:', error);
            });
    },

    // Setup auto-save functionality
    setupAutoSave() {
        setInterval(() => {
            if (this.state.isDirty) {
                this.saveData();
                this.state.isDirty = false;
            }
        }, this.config.autoSaveDelay);
    },

    // Save data to localStorage
    saveData() {
        try {
            localStorage.setItem('roadmapData', JSON.stringify(roadmapData));
            this.state.lastSaved = new Date();
        } catch (e) {
            console.error('Error saving data:', e);
        }
    },

    // Render all columns
    renderAllColumns() {
        Object.keys(roadmapData).forEach(columnId => {
            this.renderColumn(columnId, roadmapData[columnId]);
            this.updateItemCount(columnId);
        });
    },

    // Render a single column
    renderColumn(columnId, items) {
        const column = this.elements.columns[columnId];
        if (!column) return;

        const filteredItems = this.state.currentFilter
            ? items.filter(item => this.matchesFilter(item, this.state.currentFilter))
            : items;

        const sortedItems = this.sortItemsByCurrentSort(filteredItems);
        
        column.innerHTML = sortedItems.map(item => this.createItemHTML(item)).join('');
        
        // Add animation classes
        column.querySelectorAll('.roadmap-item').forEach((item, index) => {
            setTimeout(() => {
                item.style.opacity = '1';
                item.style.transform = 'translateY(0)';
            }, index * 50);
        });
    },

    // Create HTML for a single item
    createItemHTML(item) {
        const description = item.description.length > this.config.maxDescriptionLength
            ? `${item.description.substring(0, this.config.maxDescriptionLength)}...`
            : item.description;

        return `
            <div class="roadmap-item" data-item-id="${item.id}" 
                 style="opacity: 0; transform: translateY(20px); transition: all ${this.config.animationDuration}ms ease-out">
                <div class="item-title">${this.escapeHtml(item.title)}</div>
                <div class="item-description">${this.escapeHtml(description)}</div>
                <div class="item-tags">
                    ${item.tags.map(tag => `
                        <span class="item-tag">${this.escapeHtml(tag)}</span>
                    `).join('')}
                </div>
                <div class="item-meta">
                    <span class="launch-date">
                        <i class="bi bi-calendar-event"></i>
                        ${this.formatDate(item.launchDate)}
                    </span>
                    <button class="like-button ${item.liked ? 'liked' : ''}" 
                            aria-label="${item.liked ? 'Unlike' : 'Like'} this item">
                        <i class="bi bi-heart${item.liked ? '-fill' : ''}"></i>
                        <span class="like-count">${item.likes}</span>
                    </button>
                </div>
                ${item.progress !== undefined ? `
                    <div class="progress-indicator" role="progressbar" 
                         aria-valuenow="${item.progress}" aria-valuemin="0" aria-valuemax="100">
                        <div class="progress-bar" 
                             style="width: ${item.progress}%; 
                                    background-color: ${this.getProgressColor(item.progress)}">
                        </div>
                    </div>
                ` : ''}
            </div>
        `;
    },

    // Show item details in modal
    showItemDetails(itemId) {
        const item = this.findItemById(itemId);
        if (!item) return;

        const modal = document.getElementById('itemDetailModal');
        modal.querySelector('.modal-title').textContent = item.title;
        
        const detailsHTML = `
            <div class="item-details">
                <p class="description">${this.escapeHtml(item.description)}</p>
                <div class="meta-info">
                    ${this.createMetaInfoHTML(item)}
                </div>
            </div>
        `;
        
        modal.querySelector('.item-details').innerHTML = detailsHTML;
        this.renderComments(item.comments || []);
        
        this.elements.modal.show();
    },

    // Render comments for an item
    renderComments(comments) {
        const commentsList = document.querySelector('.comments-list');
        if (!commentsList) return;

        commentsList.innerHTML = comments.length > 0 
            ? comments.map(comment => `
                <div class="comment">
                    <div class="comment-meta">
                        <span class="author">${this.escapeHtml(comment.author)}</span> • 
                        <span class="date">${this.formatDate(comment.date)}</span>
                    </div>
                    <div class="comment-text">${this.escapeHtml(comment.text)}</div>
                </div>
            `).join('')
            : '<p class="text-muted">No comments yet. Be the first to share your thoughts!</p>';
    },

    // Create meta info HTML
    createMetaInfoHTML(item) {
        const metaItems = [
            { icon: 'calendar-event', label: 'Launch Date', value: this.formatDate(item.launchDate) },
            { icon: 'person', label: 'Assignee', value: item.assignee || 'Unassigned' },
            { icon: 'flag', label: 'Priority', value: item.priority || 'Not set' },
            { icon: 'heart', label: 'Likes', value: item.likes || 0 }
        ];

        return metaItems.map(meta => `
            <div class="meta-info-item">
                <i class="bi bi-${meta.icon}"></i>
                <div>
                    <div class="label">${this.escapeHtml(meta.label)}</div>
                    <div class="value">${this.escapeHtml(meta.value)}</div>
                </div>
            </div>
        `).join('');
    },

    // Handle like button click
    handleLike(event, itemId) {
        event.stopPropagation();
        const item = this.findItemById(itemId);
        if (!item) return;

        item.liked = !item.liked;
        item.likes += item.liked ? 1 : -1;
        
        const likeButton = event.target.closest('.like-button');
        this.updateLikeButton(likeButton, item);
        
        this.state.isDirty = true;
    },

    // Update like button UI
    updateLikeButton(button, item) {
        button.classList.toggle('liked');
        const icon = button.querySelector('i');
        icon.classList.toggle('bi-heart');
        icon.classList.toggle('bi-heart-fill');
        button.querySelector('.like-count').textContent = item.likes;
        
        // Add animation
        button.style.animation = 'none';
        button.offsetHeight; // Trigger reflow
        button.style.animation = 'pulse 0.3s ease-out';
    },

    // Handle comment submission
    handleCommentSubmission() {
        const textarea = this.elements.commentForm.querySelector('textarea');
        const commentText = textarea.value.trim();
        
        if (!commentText) return;

        const modalTitle = document.querySelector('#itemDetailModal .modal-title').textContent;
        const item = this.findItemByTitle(modalTitle);
        
        if (item) {
            if (!item.comments) {
                item.comments = [];
            }

            const comment = {
                author: 'You',
                date: new Date().toISOString(),
                text: commentText
            };
            
            item.comments.push(comment);
            this.renderComments(item.comments);
            textarea.value = '';
            this.state.isDirty = true;
        }
    },

    // Handle search
    handleSearch(query) {
        this.state.currentFilter = query.toLowerCase();
        this.renderAllColumns();
    },

    // Utility functions
    escapeHtml(unsafe) {
        if (unsafe === null || unsafe === undefined) {
            return '';
        }
        // Convert to string if it's not already a string
        const str = String(unsafe);
        return str
            .replace(/&/g, "&amp;")
            .replace(/</g, "&lt;")
            .replace(/>/g, "&gt;")
            .replace(/"/g, "&quot;")
            .replace(/'/g, "&#039;");
    },

    formatDate(dateString) {
        return new Date(dateString).toLocaleDateString('en-US', {
            year: 'numeric',
            month: 'short',
            day: 'numeric'
        });
    },

    getProgressColor(progress) {
        if (progress === 100) return 'var(--complete-color)';
        if (progress >= 70) return 'var(--in-progress-color)';
        if (progress >= 30) return 'var(--planned-color)';
        return 'var(--in-review-color)';
    },

    findItemById(itemId) {
        for (const column of Object.values(roadmapData)) {
            const item = column.find(item => item.id === itemId);
            if (item) return item;
        }
        return null;
    },

    findItemByTitle(title) {
        for (const column of Object.values(roadmapData)) {
            const item = column.find(item => item.title === title);
            if (item) return item;
        }
        return null;
    },

    matchesFilter(item, filter) {
        return item.title.toLowerCase().includes(filter) ||
               item.description.toLowerCase().includes(filter) ||
               item.tags.some(tag => tag.toLowerCase().includes(filter));
    },

    sortItemsByCurrentSort(items) {
        return [...items].sort((a, b) => {
            if (this.state.currentSort === 'likes') {
                return b.likes - a.likes;
            }
            return new Date(b.launchDate) - new Date(a.launchDate);
        });
    },

    debounce(func, wait) {
        let timeout;
        return function executedFunction(...args) {
            const later = () => {
                clearTimeout(timeout);
                func(...args);
            };
            clearTimeout(timeout);
            timeout = setTimeout(later, wait);
        };
    },

    updateItemCount(columnId) {
        const column = document.getElementById(columnId);
        const header = column.parentElement.querySelector('.column-header');
        const count = roadmapData[columnId].length;
        
        const countElement = header.querySelector('.item-count') || document.createElement('span');
        countElement.className = 'item-count';
        countElement.textContent = `${count} ${count === 1 ? 'item' : 'items'}`;
        
        if (!header.querySelector('.item-count')) {
            header.querySelector('h3').appendChild(countElement);
        }
    }
};

// Initialize the application when the DOM is ready
document.addEventListener('DOMContentLoaded', () => {
    RoadmapApp.init();
});
