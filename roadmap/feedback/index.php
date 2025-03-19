<?php
require_once __DIR__ . '/../../config.php';
require_once __DIR__ . '/../common/header.php';
?>
<style>
    /* Feedback Specific Styles */
    .feedback-grid {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
        gap: 1.5rem;
        margin: 2rem 0;
    }

    .feedback-item {
        background: var(--bg-white);
        border: 1px solid var(--border-color);
        border-radius: 8px;
        padding: 1.5rem;
        transition: all 0.2s ease;
        cursor: pointer;
    }

    .feedback-item:hover {
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
        transform: translateY(-2px);
    }

    .feedback-header {
        display: flex;
        justify-content: space-between;
        align-items: flex-start;
        margin-bottom: 1rem;
    }

    .feedback-title {
        font-weight: 600;
        font-size: 1.1rem;
        margin: 0;
        color: var(--text-primary);
    }

    .feedback-date {
        color: var(--text-secondary);
        font-size: 0.875rem;
        margin-left: 1rem;
        white-space: nowrap;
    }

    .feedback-description {
        color: var(--text-secondary);
        margin: 0.5rem 0;
        line-height: 1.6;
        font-size: 0.875rem;
    }

    .feedback-meta {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-top: 1rem;
        padding-top: 1rem;
        border-top: 1px solid var(--border-color);
    }

    .feedback-meta-left {
        display: flex;
        align-items: center;
        gap: 0.5rem;
    }

    .feedback-tags {
        display: flex;
        flex-wrap: wrap;
        gap: 0.5rem;
    }

    .feedback-tag {
        display: inline-flex;
        align-items: center;
        padding: 0.25rem 0.75rem;
        border-radius: 999px;
        font-size: 0.75rem;
        font-weight: 500;
        background: var(--bg-gray);
        color: var(--text-secondary);
    }

    .feedback-tag.status-planned {
        background-color: var(--planned-color);
        color: white;
    }

    .feedback-tag.status-in-review {
        background-color: var(--in-review-color);
        color: white;
    }

    .feedback-tag.status-in-progress {
        background-color: var(--in-progress-color);
        color: white;
    }

    .feedback-tag.status-completed {
        background-color: var(--completed-color);
        color: white;
    }

    .vote-button {
        display: inline-flex;
        align-items: center;
        gap: 0.5rem;
        padding: 0.5rem 1rem;
        border: 1px solid var(--border-color);
        border-radius: 6px;
        background: var(--bg-white);
        color: var(--text-secondary);
        font-size: 0.875rem;
        font-weight: 500;
        cursor: pointer;
        transition: all 0.2s ease;
    }

    .vote-button:hover {
        background: var(--hover-gray);
        border-color: var(--accent-color);
        color: var(--accent-color);
    }

    .vote-button.voted {
        background: var(--accent-color);
        border-color: var(--accent-color);
        color: var(--bg-white);
    }

    .vote-button i {
        font-size: 1rem;
        transition: transform 0.2s ease;
    }

    .vote-button:hover i {
        transform: translateY(-2px);
    }

    /* Modal Styles */
    .feedback-modal {
        display: none;
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0, 0, 0, 0.5);
        z-index: 1000;
    }

    .feedback-modal-content {
        position: relative;
        background: var(--bg-white);
        width: 90%;
        max-width: 600px;
        margin: 2rem auto;
        padding: 2rem;
        border-radius: 8px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
    }

    .feedback-form {
        display: flex;
        flex-direction: column;
        gap: 1.5rem;
    }

    .form-group {
        display: flex;
        flex-direction: column;
        gap: 0.5rem;
    }

    .form-label {
        font-weight: 500;
        color: var(--text-primary);
    }

    .form-input,
    .form-textarea {
        padding: 0.75rem;
        border: 1px solid var(--border-color);
        border-radius: 6px;
        font-size: 0.875rem;
    }

    .form-textarea {
        resize: vertical;
        min-height: 100px;
    }

    .notification {
        padding: 0.75rem 1rem;
        margin-top: 1rem;
        border-radius: 6px;
        font-size: 0.875rem;
        display: none;
        width: 100%;
    }

    .notification.success {
        background: #e6f4ea;
        color: #1e4620;
        border: 1px solid #c6e7c6;
    }

    .notification.error {
        background: #fce8e8;
        color: #c62828;
        border: 1px solid #fad2d2;
    }

    /* Add Modal Styles */
    .modal {
        display: none;
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0, 0, 0, 0.5);
        z-index: 1000;
    }

    .modal-content {
        position: relative;
        background: var(--bg-white);
        width: 90%;
        max-width: 600px;
        margin: 2rem auto;
        padding: 2rem;
        border-radius: 8px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
    }

    .modal-header {
        padding: 1.5rem;
        border-bottom: 1px solid var(--border-color);
    }

    .modal-title {
        font-size: 1.25rem;
        font-weight: 600;
        color: var(--text-primary);
        margin: 0;
    }

    .modal-close {
        position: absolute;
        top: 1.25rem;
        right: 1.25rem;
        font-size: 1.25rem;
        color: var(--text-secondary);
        cursor: pointer;
        border: none;
        background: none;
        padding: 0.25rem;
    }

    .modal-body {
        padding: 1.5rem;
        max-height: calc(100vh - 200px);
        overflow-y: auto;
    }

    .modal-info {
        margin-bottom: 1.5rem;
    }

    .modal-info-item {
        margin-bottom: 1rem;
    }

    .modal-info-label {
        font-weight: 500;
        color: var(--text-secondary);
        margin-bottom: 0.25rem;
    }

    .modal-info-value {
        color: var(--text-primary);
    }

    .comments-section {
        border-top: 1px solid var(--border-color);
        padding-top: 1.5rem;
    }

    .comments-list {
        margin-bottom: 1.5rem;
    }

    .comment {
        padding: 1rem;
        background: var(--bg-gray);
        border-radius: 6px;
        margin-bottom: 1rem;
    }

    .comment:last-child {
        margin-bottom: 0;
    }

    .comment-header {
        display: flex;
        justify-content: space-between;
        margin-bottom: 0.5rem;
        font-size: 0.875rem;
        color: var(--text-secondary);
    }

    .comment-text {
        color: var(--text-primary);
        font-size: 0.875rem;
        line-height: 1.5;
    }

    /* Update comment form styles */
    .comment-input-group {
        margin-bottom: 1rem;
    }

    .comment-input {
        width: 100%;
        min-height: 80px;
        padding: 0.75rem;
        border: 1px solid var(--border-color);
        border-radius: 4px;
        margin-bottom: 0.5rem;
        resize: vertical;
    }

    .comment-submit {
        padding: 0.75rem 1.5rem;
        background: var(--accent-color);
        color: white;
        border: none;
        border-radius: 6px;
        cursor: pointer;
        font-size: 0.875rem;
        transition: background 0.2s ease;
    }

    .comment-submit:disabled {
        opacity: 0.7;
        cursor: not-allowed;
    }

    .modal-date {
        color: var(--text-secondary);
        font-size: 0.875rem;
        margin-bottom: 1rem;
    }

    .modal-tags {
        display: flex;
        flex-wrap: wrap;
        gap: 0.5rem;
        margin-top: 1rem;
    }

    @media (max-width: 768px) {
        .feedback-grid {
            grid-template-columns: 1fr;
        }
    }

    /* Add Feedback Form Styles */
    .form-group {
        margin-bottom: 1rem;
    }

    .form-group label {
        display: block;
        margin-bottom: 0.5rem;
        color: var(--text-primary);
        font-weight: 500;
    }

    .form-group input,
    .form-group textarea {
        width: 100%;
        padding: 0.75rem;
        border: 1px solid var(--border-color);
        border-radius: 6px;
        font-size: 0.875rem;
    }

    .form-group textarea {
        resize: vertical;
        min-height: 100px;
    }

    .form-actions {
        margin-top: 1.5rem;
        text-align: right;
        display: flex;
        justify-content: flex-end;
        gap: 1rem;
    }

    .submit-button,
    .cancel-button {
        padding: 0.75rem 1.5rem;
        border-radius: 6px;
        cursor: pointer;
        font-size: 0.875rem;
        transition: all 0.2s ease;
    }

    .submit-button {
        background: var(--accent-color);
        color: white;
        border: none;
    }

    .submit-button:hover {
        background: var(--accent-color-dark);
    }

    .submit-button:disabled {
        opacity: 0.7;
        cursor: not-allowed;
    }

    .cancel-button {
        background: var(--bg-white);
        color: var(--text-secondary);
        border: 1px solid var(--border-color);
    }

    .cancel-button:hover {
        background: var(--hover-gray);
        border-color: var(--accent-color);
        color: var(--accent-color);
    }

    .form-input,
    .form-textarea,
    select.form-input {
        width: 100%;
        padding: 0.75rem;
        border: 1px solid var(--border-color);
        border-radius: 6px;
        font-size: 0.875rem;
        background: var(--bg-white);
    }

    select.form-input {
        cursor: pointer;
    }

    select.form-input:hover {
        border-color: var(--accent-color);
    }

    /* Search and Filter Styles */
    .feedback-controls {
        display: flex;
        gap: 1rem;
        margin-bottom: 2rem;
        flex-wrap: wrap;
    }

    .search-box {
        flex: 1;
        min-width: 200px;
        position: relative;
    }

    .search-box i {
        position: absolute;
        left: 1rem;
        top: 50%;
        transform: translateY(-50%);
        color: var(--text-secondary);
    }

    .search-input {
        width: 100%;
        padding: 0.75rem 1rem 0.75rem 2.5rem;
        border: 1px solid var(--border-color);
        border-radius: 6px;
        font-size: 0.875rem;
        background: var(--bg-white);
    }

    .search-input:focus {
        outline: none;
        border-color: var(--accent-color);
    }

    .filter-group {
        display: flex;
        gap: 1rem;
    }

    .filter-select {
        padding: 0.75rem 2rem 0.75rem 1rem;
        border: 1px solid var(--border-color);
        border-radius: 6px;
        font-size: 0.875rem;
        background: var(--bg-white);
        cursor: pointer;
        min-width: 140px;
    }

    .filter-select:hover {
        border-color: var(--accent-color);
    }
</style>
</head>
<?php require_once __DIR__ . '/../common/top.php';?>

<div class="section-header">
    <h2 class="section-title"></h2>
    <button onclick="openAddFeedbackModal()" class="add-feedback-button button">
    <i class="fa-solid fa-plus"></i> Add Feedback
</button>
</div>

<div class="feedback-controls">
    <div class="search-box">
        <i class="fas fa-search"></i>
        <input type="text" id="searchInput" class="search-input" placeholder="Search feedback...">
    </div>
    <div class="filter-group">
        <select id="typeFilter" class="filter-select">
            <option value="">All Types</option>
            <option value="General">General</option>
            <option value="Bug">Bug</option>
            <option value="Feature">Feature</option>
            <option value="Enhancement">Enhancement</option>
            <option value="Documentation">Documentation</option>
        </select>
        <select id="sortSelect" class="filter-select">
            <option value="votes">Most Voted</option>
            <option value="date">Latest</option>
        </select>
    </div>
</div>

<div class="feedback-grid" id="feedbackGrid"></div>

<!-- Add Feedback Modal -->
<div class="modal" id="addFeedbackModal">
    <div class="modal-content">
        <h2>Add Feedback</h2>
        <form id="feedbackForm" onsubmit="submitFeedback(event)">
            <div class="form-group">
                <label for="feedbackTitle">Title</label>
                <input type="text" id="feedbackTitle" required>
            </div>
            <div class="form-group">
                <label for="feedbackDescription">Description</label>
                <textarea id="feedbackDescription" rows="4"></textarea>
            </div>
            <div class="form-group">
                <label for="feedbackTags">Type</label>
                <select id="feedbackTags" class="form-input">
                    <option value="General">General</option>
                    <option value="Bug">Bug</option>
                    <option value="Feature">Feature</option>
                    <option value="Enhancement">Enhancement</option>
                    <option value="Documentation">Documentation</option>
                </select>
            </div>
            <div class="form-actions">
                <button type="button" onclick="closeAddFeedbackModal()" class="cancel-button">Cancel</button>
                <button type="submit" class="submit-button">Submit</button>
            </div>
            <div class="notification success" id="successNotification"></div>
            <div class="notification error" id="errorNotification"></div>
        </form>
    </div>
</div>

<!-- Add Modal Dialog -->
<div class="modal" id="itemModal">
    <div class="modal-content">
        <div class="modal-header">
            <h3 class="modal-title"></h3>
            <button class="modal-close" onclick="closeModal()">
                <i class="fa-solid fa-times"></i>
            </button>
        </div>
        <div class="modal-body">
            <div class="modal-info">
                <div class="modal-date"></div>
                <div class="modal-info-item">
                    <div class="modal-info-value description"></div>
                </div>
                <div class="modal-tags"></div>
            </div>
            <div class="comments-section">
                <h4>Comments</h4>
                <div class="comments-list"></div>
                <form class="comment-form" onsubmit="submitComment(event)">
                    <input type="hidden" id="commentItemId">
                    <div class="comment-input-group">
                        <textarea class="comment-input" placeholder="Add a comment..." required></textarea>
                        <button type="submit" class="comment-submit">Submit</button>
                    </div>
                    <div class="notification success" id="successNotification">Comment added successfully!</div>
                    <div class="notification error" id="errorNotification">Failed to add comment. Please try again.</div>
                </form>
            </div>
        </div>
    </div>
</div>

<?php require_once __DIR__ . '/../common/bottom.php';?>
<script>
    function getStoredVotes() {
        const votes = localStorage.getItem('roadmapVotes');
        return votes ? JSON.parse(votes) : {};
    }

    function getStoredClickCounts() {
        const clicks = localStorage.getItem('roadmapClickCounts');
        return clicks ? JSON.parse(clicks) : {};
    }

    function canVote(itemId) {
        const clickCounts = getStoredClickCounts();
        return !clickCounts[itemId] || clickCounts[itemId] < 3;
    }

    function updateVoteState(itemId, newState) {
        const votes = getStoredVotes();
        votes[itemId] = newState;
        localStorage.setItem('roadmapVotes', JSON.stringify(votes));

        // Update click count
        const clickCounts = getStoredClickCounts();
        clickCounts[itemId] = (clickCounts[itemId] || 0) + 1;
        localStorage.setItem('roadmapClickCounts', JSON.stringify(clickCounts));

        // Return true if we should disable the button (reached 3 clicks)
        return clickCounts[itemId] >= 3;
    }

    async function toggleVote(event, button) {
        event.stopPropagation();
        const itemId = button.dataset.id;
        
        // Check if voting is allowed
        if (!canVote(itemId)) {
            return;
        }

        const currentState = button.dataset.voteState;
        let newState = 'none';
        let endpoint = '';

        if (currentState === 'none') {
            newState = 'up';
            endpoint = '/roadmap_api/like/';
        } else if (currentState === 'up') {
            newState = 'down';
            endpoint = '/roadmap_api/dislike/';
        } else if (currentState === 'down') {
            newState = 'none';
            endpoint = '/roadmap_api/like/'; // Reset vote
        }

        try {
            const response = await fetch(endpoint, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                    itemId: itemId
                })
            });

            if (response.ok) {
                // Update button state
                button.dataset.voteState = newState;
                button.className = `vote-button${newState === 'up' ? ' voted' : (newState === 'down' ? ' voted-down' : '')}`;

                // Update localStorage and check if we should disable
                const shouldDisable = updateVoteState(itemId, newState);
                if (shouldDisable) {
                    button.disabled = true;
                }

                // Refresh the feedback to update vote counts
                await loadFeedback();
            }
        } catch (error) {
            console.error('Error:', error);
        }
    }

    document.addEventListener("DOMContentLoaded", function() {
        loadFeedback();

        // Close modal when clicking outside
        const modal = document.getElementById('feedbackModal');
        window.addEventListener('click', function(event) {
            if (event.target === modal) {
                closeFeedbackModal();
            }
        });
    });

    async function loadFeedback() {
        try {
            const response = await fetch('/roadmap_api/');
            const result = await response.json();
            
            if (result.status === 'ok' && result.data && result.data.feedback) {
                const feedbackGrid = document.getElementById('feedbackGrid');
                feedbackGrid.innerHTML = '';
                
                // Only use feedback data and sort by likes
                const feedbackItems = result.data.feedback.sort((a, b) => (b.likes || 0) - (a.likes || 0));
                
                feedbackItems.forEach(item => {
                    // Add vote state from localStorage
                    const storedVotes = getStoredVotes();
                    item.voteState = storedVotes[item.id] || 'none';
                    
                    const feedbackElement = document.createElement('div');
                    feedbackElement.className = 'feedback-item';
                    
                    feedbackElement.innerHTML = `
                        <div class="feedback-header">
                            <h3 class="feedback-title">${item.title}</h3>
                            <span class="feedback-date">${formatDate(item.launchDate)}</span>
                        </div>
                        <p class="feedback-description">${item.description || ''}</p>
                        <div class="feedback-meta">
                            <div class="feedback-meta-left">
                                ${item.tags ? `
                                    <div class="feedback-tags">
                                        ${item.tags.map(tag => {
                                            const statusClass = getStatusTagClass(tag);
                                            return `<span class="feedback-tag ${statusClass}">${tag}</span>`;
                                        }).join('')}
                                    </div>
                                ` : ''}
                            </div>
                            <div class="vote-button${item.voteState === 'up' ? ' voted' : (item.voteState === 'down' ? ' voted-down' : '')}" 
                                onclick="toggleVote(event, this)" 
                                data-id="${item.id}" 
                                data-vote-state="${item.voteState}"
                                ${!canVote(item.id) ? 'disabled' : ''}>
                                <i class="fa-solid fa-caret-up"></i>
                                <span class="vote-count">${item.likes || 0}</span>
                            </div>
                        </div>
                    `;
                    
                    feedbackElement.onclick = () => openModal(item);
                    
                    feedbackGrid.appendChild(feedbackElement);
                });
            }
        } catch (error) {
            console.error('Error:', error);
        }
    }

    function openFeedbackModal() {
        const modal = document.getElementById('feedbackModal');
        const form = document.getElementById('feedbackForm');
        const successNotification = document.getElementById('successNotification');
        const errorNotification = document.getElementById('errorNotification');

        // Reset form and notifications
        form.reset();
        
        // Hide notifications
        successNotification.style.display = 'none';
        errorNotification.style.display = 'none';

        modal.style.display = 'block';
        document.body.style.overflow = 'hidden';
    }

    function closeFeedbackModal() {
        const modal = document.getElementById('feedbackModal');
        modal.style.display = 'none';
        document.body.style.overflow = '';
    }

    function openModal(item) {
        const modal = document.getElementById('itemModal');
        const title = modal.querySelector('.modal-title');
        const description = modal.querySelector('.description');
        const date = modal.querySelector('.modal-date');
        const tags = modal.querySelector('.modal-tags');
        const commentsList = modal.querySelector('.comments-list');
        const commentItemId = modal.querySelector('#commentItemId');
        const successNotification = modal.querySelector('#successNotification');
        const errorNotification = modal.querySelector('#errorNotification');

        // Reset notifications
        successNotification.style.display = 'none';
        errorNotification.style.display = 'none';

        title.textContent = item.title;
        description.textContent = item.description || 'No description available';
        date.textContent = formatDate(item.launchDate);
        commentItemId.value = item.id;

        // Render tags
        tags.innerHTML = '';
        if (item.tags && item.tags.length > 0) {
            item.tags.forEach(tag => {
                const tagElement = document.createElement('span');
                tagElement.className = 'feedback-tag';
                tagElement.textContent = tag;
                tags.appendChild(tagElement);
            });
        }

        // Reset comment input
        modal.querySelector('.comment-input').value = '';

        // Render comments
        commentsList.innerHTML = '';
        if (item.comments && item.comments.length > 0) {
            item.comments.forEach(comment => {
                const commentElement = document.createElement('div');
                commentElement.className = 'comment';
                commentElement.innerHTML = `
                    <div class="comment-header">
                        <span>${comment.user || 'Anonymous'}</span>
                        <span>${formatDate(comment.date)}</span>
                    </div>
                    <div class="comment-text">${comment.text}</div>
                `;
                commentsList.appendChild(commentElement);
            });
        } else {
            commentsList.innerHTML = '<p>No comments yet</p>';
        }

        modal.style.display = 'block';
        document.body.style.overflow = 'hidden';
    }

    function closeModal() {
        const modal = document.getElementById('itemModal');
        modal.style.display = 'none';
        document.body.style.overflow = '';
        modal.querySelector('.comment-input').value = '';
    }

    async function submitComment(event) {
        event.preventDefault();
        const form = event.target;
        const itemId = form.querySelector('#commentItemId').value;
        const input = form.querySelector('.comment-input');
        const submitButton = form.querySelector('.comment-submit');
        const successNotification = form.querySelector('#successNotification');
        const errorNotification = form.querySelector('#errorNotification');
        const text = input.value.trim();

        if (!text) return;

        // Hide notifications
        successNotification.style.display = 'none';
        errorNotification.style.display = 'none';
        submitButton.disabled = true;

        try {
            const response = await fetch('/roadmap_api/comment/', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                    itemId: itemId,
                    text: text
                })
            });

            if (response.ok) {
                // Clear the input
                input.value = '';
                
                // Show success notification
                successNotification.style.display = 'block';
                
                // Fetch updated data
                const feedbackResponse = await fetch('/roadmap_api/');
                const result = await feedbackResponse.json();
                
                if (result.status === 'ok' && result.data && result.data.feedback) {
                    // Find the updated item
                    const item = result.data.feedback.find(item => item.id === itemId);
                    if (item) {
                        const commentsList = document.querySelector('.comments-list');
                        commentsList.innerHTML = '';
                        if (item.comments && item.comments.length > 0) {
                            item.comments.forEach(comment => {
                                const commentElement = document.createElement('div');
                                commentElement.className = 'comment';
                                commentElement.innerHTML = `
                                    <div class="comment-header">
                                        <span>${comment.user || 'Anonymous'}</span>
                                        <span>${formatDate(comment.date)}</span>
                                    </div>
                                    <div class="comment-text">${comment.text}</div>
                                `;
                                commentsList.appendChild(commentElement);
                            });
                        } else {
                            commentsList.innerHTML = '<p>No comments yet</p>';
                        }
                    }
                }
                
                // Refresh the feedback list
                await loadFeedback();
            } else {
                // Show error notification
                errorNotification.style.display = 'block';
            }
        } catch (error) {
            console.error('Error:', error);
            errorNotification.style.display = 'block';
        } finally {
            submitButton.disabled = false;
            
            // Auto-hide notifications after 3 seconds
            setTimeout(() => {
                successNotification.style.display = 'none';
                errorNotification.style.display = 'none';
            }, 3000);
        }
    }

    function getStatusTagClass(tag) {
        const statusMap = {
            'Planned': 'status-planned',
            'In Review': 'status-in-review',
            'In Progress': 'status-in-progress',
            'Completed': 'status-completed'
        };
        return statusMap[tag] || '';
    }

    function formatDate(dateString) {
        const date = new Date(dateString);
        return date.toLocaleDateString('en-US', {
            year: 'numeric',
            month: 'short',
            day: 'numeric'
        });
    }

    // Add this to your existing JavaScript
    async function submitFeedback(event) {
        event.preventDefault();
        const form = event.target;
        const title = form.querySelector('#feedbackTitle').value.trim();
        const description = form.querySelector('#feedbackDescription').value.trim();
        const tag = form.querySelector('#feedbackTags').value;
        const submitButton = form.querySelector('button[type="submit"]');
        const successNotification = document.querySelector('#successNotification');
        const errorNotification = document.querySelector('#errorNotification');

        if (!title) {
            errorNotification.textContent = 'Title is required';
            errorNotification.style.display = 'block';
            return;
        }

        // Hide notifications
        successNotification.style.display = 'none';
        errorNotification.style.display = 'none';
        submitButton.disabled = true;

        try {
            const response = await fetch('/roadmap_api/feedback/', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                    title,
                    description,
                    tags: [tag]
                })
            });

            const result = await response.json();
            if (result.status === 'ok') {
                // Clear form
                form.reset();
                
                // Show success notification
                successNotification.textContent = 'Feedback submitted successfully!';
                successNotification.style.display = 'block';
                
                // Refresh feedback list
                await loadFeedback();
                
                // Close modal if it exists
                const modal = document.querySelector('.modal');
                if (modal) {
                    modal.style.display = 'none';
                }
            } else {
                throw new Error(result.message);
            }
        } catch (error) {
            console.error('Error:', error);
            errorNotification.textContent = error.message || 'Failed to submit feedback';
            errorNotification.style.display = 'block';
        } finally {
            submitButton.disabled = false;
            
            // Auto-hide notifications after 3 seconds
            setTimeout(() => {
                successNotification.style.display = 'none';
                errorNotification.style.display = 'none';
            }, 3000);
        }
    }
    function openAddFeedbackModal() {
        const modal = document.getElementById('addFeedbackModal');
        modal.style.display = 'block';
        document.body.style.overflow = 'hidden';
    }

    function closeAddFeedbackModal() {
        const modal = document.getElementById('addFeedbackModal');
        modal.style.display = 'none';
        document.body.style.overflow = '';
        modal.querySelector('form').reset();
        modal.querySelector('#successNotification').style.display = 'none';
        modal.querySelector('#errorNotification').style.display = 'none';
    }

    function filterFeedback() {
        const searchQuery = document.getElementById('searchInput').value.toLowerCase();
        const typeFilter = document.getElementById('typeFilter').value;
        const sortBy = document.getElementById('sortSelect').value;
        const feedbackItems = document.querySelectorAll('.feedback-item');

        feedbackItems.forEach(item => {
            const title = item.querySelector('.feedback-title').textContent.toLowerCase();
            const description = item.querySelector('.feedback-description').textContent.toLowerCase();
            const tags = Array.from(item.querySelectorAll('.feedback-tag')).map(tag => tag.textContent.toLowerCase());
            
            const matchesSearch = title.includes(searchQuery) || description.includes(searchQuery);
            const matchesType = !typeFilter || tags.includes(typeFilter.toLowerCase());
            
            item.style.display = (matchesSearch && matchesType) ? '' : 'none';
        });

        // Sort items
        const feedbackGrid = document.getElementById('feedbackGrid');
        const items = Array.from(feedbackItems);
        items.sort((a, b) => {
            if (sortBy === 'votes') {
                const votesA = parseInt(a.querySelector('.vote-count').textContent) || 0;
                const votesB = parseInt(b.querySelector('.vote-count').textContent) || 0;
                return votesB - votesA;
            } else {
                const dateA = new Date(a.querySelector('.feedback-date').textContent);
                const dateB = new Date(b.querySelector('.feedback-date').textContent);
                return dateB - dateA;
            }
        });

        items.forEach(item => feedbackGrid.appendChild(item));
    }

    // Add event listeners for search and filters
    document.getElementById('searchInput').addEventListener('input', filterFeedback);
    document.getElementById('typeFilter').addEventListener('change', filterFeedback);
    document.getElementById('sortSelect').addEventListener('change', filterFeedback);
</script>
<?php require_once __DIR__ . '/../common/footer.php'; ?>
