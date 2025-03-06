// Roadmap Application
const RoadmapApp = {
    // Configuration
    config: {
        animationDuration: 300,
        maxDescriptionLength: 100,
        itemsPerPage: 10,
        endpoints: {
            roadmap: '/roadmap/',
            like: '/roadmap/like/',
            disLike: '/roadmap/dislike/',
            comment: '/roadmap/comment/'
        }
    },

    // State
    state: {
        currentSort: 'date',
        currentFilter: '',
        data: null,
        loading: false,
        error: null
    },

    // Cache DOM elements
    elements: {
        modalElement: null,
        modal: null,
        columns: {},
        commentForm: null,
        errorContainer: null,
        loadingIndicator: null
    },

    // Initialize the application
    async init() {
        this.cacheElements();
        await this.loadData();
        this.bindEvents();
    },

    // Cache frequently used DOM elements
    cacheElements() {
        const modalElement = document.getElementById('itemDetailModal');
        this.elements.modalElement = modalElement;
        this.elements.modal = new bootstrap.Modal(modalElement);
        this.elements.commentForm = document.querySelector('.add-comment');
        this.elements.loadingIndicator = document.createElement('div');
        this.elements.loadingIndicator.className = 'loading-indicator';
        this.elements.loadingIndicator.innerHTML = '<div class="spinner-border text-primary" role="status"><span class="visually-hidden">Loading...</span></div>';

        // Cache column elements
        ['in-review', 'planned', 'in-progress', 'complete'].forEach(columnId => {
            this.elements.columns[columnId] = document.getElementById(columnId);
        });
    },

    // Load data from API
    async loadData() {
        try {
            this.showLoading();
            const response = await fetch(this.config.endpoints.roadmap);
            const result = await response.json();

            if (result.status === 'ok') {
                this.state.data = result.data;
                this.renderAllColumns();
            } else {
                throw new Error(result.message || 'Failed to load roadmap data');
            }
        } catch (error) {
            console.error('Error loading roadmap data:', error);
            this.showError('Unable to load roadmap data. Please try refreshing the page.');
        } finally {
            this.hideLoading();
        }
    },

    // Show loading indicator
    showLoading() {
        this.state.loading = true;
        document.querySelector('.roadmap-container').prepend(this.elements.loadingIndicator);
    },

    // Hide loading indicator
    hideLoading() {
        this.state.loading = false;
        this.elements.loadingIndicator.remove();
    },

    // Show error message
    showError(message) {
        if (!this.elements.errorContainer) {
            this.elements.errorContainer = document.createElement('div');
            this.elements.errorContainer.className = 'alert alert-danger mt-3';
            document.querySelector('.roadmap-container').prepend(this.elements.errorContainer);
        }
        this.elements.errorContainer.textContent = message;
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

    // Render all columns
    renderAllColumns() {
        if (!this.state.data) return;

        Object.keys(this.state.data).forEach(columnId => {
            this.renderColumn(columnId, this.state.data[columnId]);
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

        // Check localStorage for like state
        const isLiked = localStorage.getItem(`like-${item.id}`) !== null;

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
                    <button class="like-button ${isLiked ? 'liked' : ''}" 
                            aria-label="${isLiked ? 'Unlike' : 'Like'} this item">
                        <i class="bi bi-heart${isLiked ? '-fill' : ''}"></i>
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
        modal.querySelector('.modal-content').dataset.itemId = itemId;

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
    async handleLike(event, itemId) {
        event.preventDefault();
        event.stopPropagation();

        const likeButton = event.target.closest('.like-button');
        if (!likeButton) return;
        let _actionLike = true;
        let _actionLikeEndpoints = this.config.endpoints.like;
        if (localStorage.getItem('like-'+itemId)) {
            if (confirm("Are you sure to cancel your vote for this item?")) {
                _actionLike = false;
                _actionLikeEndpoints = this.config.endpoints.disLike;
            } else {
                return;
            }
        }
        try {
            likeButton.disabled = true;
            const response = await fetch(_actionLikeEndpoints, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    itemId: itemId
                })
            });

            const result = await response.json();
            if (result.status === 'ok') {
                const item = this.findItemById(itemId);
                if (item) {
                    item.likes = result.data.likes;
                    if (_actionLike) {
                        localStorage.setItem('like-'+itemId, 1);
                    } else {
                        localStorage.removeItem('like-'+itemId);
                    }
                    this.updateLikeButton(likeButton, item);
                }
            } else {
                throw new Error(result.message || 'Failed to update like');
            }
        } catch (error) {
            console.error('Error updating like:', error);
            this.showError('Unable to update like. Please try again.');
        } finally {
            likeButton.disabled = false;
        }
    },

    // Update like button UI
    updateLikeButton(button, item) {
        const isLiked = localStorage.getItem(`like-${item.id}`) !== null;
        console.log("like-"+item.id+",isLiked:"+isLiked);

        // Update button classes based on localStorage state
        button.classList.toggle('liked', isLiked);
        const icon = button.querySelector('i');
        icon.classList.remove('bi-heart', 'bi-heart-fill');
        icon.classList.add(isLiked ? 'bi-heart-fill' : 'bi-heart');

        // Update like count and aria-label
        button.querySelector('.like-count').textContent = item.likes;
        button.setAttribute('aria-label', `${isLiked ? 'Unlike' : 'Like'} this item`);

        // Add animation
        button.style.animation = 'none';
        button.offsetHeight; // Trigger reflow
        button.style.animation = 'pulse 0.3s ease-out';
    },

    // Handle comment submission
    async handleCommentSubmission() {
        const textarea = this.elements.commentForm.querySelector('textarea');
        const text = textarea.value.trim();
        const itemId = this.elements.modalElement.querySelector('.modal-content').dataset.itemId;
        if (!text || !itemId) return;

        try {
            const submitButton = this.elements.commentForm.querySelector('button');
            submitButton.disabled = true;

            const response = await fetch(this.config.endpoints.comment, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    itemId: itemId,
                    text: text
                })
            });

            const result = await response.json();
            if (result.status === 'ok') {
                const item = this.findItemById(parseInt(itemId));
                if (item) {
                    item.comments = result.data.comments;
                    this.renderComments(item.comments);
                    textarea.value = '';
                }
            } else {
                throw new Error(result.message || 'Failed to add comment');
            }
        } catch (error) {
            console.error('Error adding comment:', error);
            this.showError('Unable to add comment. Please try again.');
        } finally {
            submitButton.disabled = false;
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
        if (!this.state.data) return null;
        for (const column of Object.values(this.state.data)) {
            const item = column.find(item => item.id == itemId);
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
        if (!this.state.data || !this.state.data[columnId]) return;

        const column = document.getElementById(columnId);
        const header = column.parentElement.querySelector('.column-header');
        const count = this.state.data[columnId].length;

        const countElement = header.querySelector('.item-count') || document.createElement('span');
        countElement.className = 'item-count';
        countElement.textContent = `(${count})`;
        if (!header.querySelector('.item-count')) {
            header.querySelector('h3').appendChild(countElement);
        }
    }
};

// Initialize the application when the DOM is ready
document.addEventListener('DOMContentLoaded', () => {
    RoadmapApp.init();
});
