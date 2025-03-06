<?php require_once __DIR__ . '/../config.php'; ?>
<?php require_once __DIR__ . '/common/header.php';?>
<style>
    /* Roadmap Specific Styles */
    .roadmap {
        display: grid;
        grid-template-columns: repeat(4, 1fr);
        gap: 1.5rem;
        margin-bottom: 3rem;
        height: calc(100vh - 200px);
        min-height: 500px;
    }

    .roadmap-column {
        background: var(--bg-gray);
        border-radius: 8px;
        padding: 1rem;
        display: flex;
        flex-direction: column;
    }

    .roadmap-header {
        padding-bottom: 1rem;
        margin-bottom: 1rem;
        border-bottom: 1px solid var(--border-color);
        flex-shrink: 0;
    }

    .roadmap-title {
        font-weight: 600;
        display: flex;
        align-items: center;
        gap: 0.5rem;
        color: var(--text-primary);
    }

    .roadmap-count {
        color: var(--text-secondary);
        font-size: 0.875rem;
        background: var(--bg-white);
        padding: 0.25rem 0.75rem;
        border-radius: 1rem;
        margin-left: auto;
    }

    .roadmap-items {
        overflow-y: auto;
        flex-grow: 1;
        padding-right: 0.5rem;
    }

    /* Custom scrollbar for roadmap-items */
    .roadmap-items::-webkit-scrollbar {
        width: 6px;
    }

    .roadmap-items::-webkit-scrollbar-track {
        background: var(--bg-gray);
        border-radius: 3px;
    }

    .roadmap-items::-webkit-scrollbar-thumb {
        background: var(--border-color);
        border-radius: 3px;
    }

    .roadmap-items::-webkit-scrollbar-thumb:hover {
        background: var(--text-secondary);
    }

    .roadmap-item {
        background: var(--bg-white);
        border-radius: 6px;
        padding: 1rem;
        margin-bottom: 0.75rem;
        border: 1px solid var(--border-color);
        transition: all 0.2s ease;
        cursor: pointer;
    }

    .roadmap-item:last-child {
        margin-bottom: 0;
    }

    .roadmap-item:hover {
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
        transform: translateY(-1px);
    }

    .roadmap-item-title {
        font-weight: 600;
        font-size: 1rem;
        margin-bottom: 0.5rem;
        color: var(--text-primary);
    }

    .roadmap-item-description {
        color: var(--text-secondary);
        font-size: 0.875rem;
        margin-bottom: 0.75rem;
    }

    .roadmap-tags {
        display: flex;
        flex-wrap: wrap;
        gap: 0.5rem;
        margin-bottom: 0.75rem;
    }

    .roadmap-tag {
        font-size: 0.75rem;
        padding: 0.25rem 0.75rem;
        border-radius: 1rem;
        background: var(--bg-gray);
        color: var(--text-secondary);
        transition: all 0.2s ease;
        position: relative;
        background-clip: padding-box;
        border: 2px solid #00000014;
        box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);
    }

    .roadmap-tag::before {
        content: '';
        position: absolute;
        top: -2px;
        right: -2px;
        bottom: -2px;
        left: -2px;
        z-index: -1;
        border-radius: inherit;
        background: linear-gradient(45deg, rgba(255,255,255,0.8), rgba(255,255,255,0.3));
    }

    /* Priority tags */
    .roadmap-tag:has(:-webkit-any(High, Medium, Low)) {
        font-weight: 600;
    }

    .roadmap-tag:contains("High Priority") {
        background-color: #fee2e2;
        color: #dc2626;
    }

    .roadmap-tag:contains("High Priority")::before {
        background: linear-gradient(45deg, #fca5a5, #ef4444);
    }

    .roadmap-tag:contains("Medium Priority") {
        background-color: #fef3c7;
        color: #d97706;
    }

    .roadmap-tag:contains("Medium Priority")::before {
        background: linear-gradient(45deg, #fcd34d, #f59e0b);
    }

    .roadmap-tag:contains("Low Priority") {
        background-color: #dcfce7;
        color: #16a34a;
    }

    .roadmap-tag:contains("Low Priority")::before {
        background: linear-gradient(45deg, #86efac, #22c55e);
    }

    /* Launch date tag */
    .roadmap-tag:contains("Launch:") {
        background-color: #dbeafe;
        color: #2563eb;
    }

    .roadmap-tag:contains("Launch:")::before {
        background: linear-gradient(45deg, #93c5fd, #3b82f6);
    }

    /* Progress tag */
    .roadmap-tag:contains("Progress:") {
        background-color: #f3e8ff;
        color: #9333ea;
    }

    .roadmap-tag:contains("Progress:")::before {
        background: linear-gradient(45deg, #c084fc, #9333ea);
    }

    /* Other tags */
    .roadmap-tag:not(:contains("Priority"), :contains("Launch:"), :contains("Progress:")) {
        background-color: #f1f5f9;
        color: #475569;
    }

    .roadmap-tag:not(:contains("Priority"), :contains("Launch:"), :contains("Progress:"))::before {
        background: linear-gradient(45deg, #cbd5e1, #94a3b8);
    }

    .roadmap-tag:hover {
        transform: translateY(-1px);
        box-shadow: 0 3px 6px rgba(0, 0, 0, 0.1);
    }

    .roadmap-tag:hover::before {
        opacity: 0.9;
        filter: brightness(1.1);
    }

    .roadmap-meta {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding-top: 0.75rem;
        border-top: 1px solid var(--border-color);
    }

    .roadmap-controls {
        margin-bottom: 2rem;
        display: flex;
        gap: 1rem;
        align-items: center;
        flex-wrap: wrap;
    }

    .roadmap-search {
        flex: 1;
        min-width: 200px;
    }

    .roadmap-search input {
        width: 100%;
        padding: 0.75rem 1rem;
        border: 1px solid var(--border-color);
        border-radius: 8px;
        font-size: 0.875rem;
        transition: all 0.2s ease;
    }

    .roadmap-search input:focus {
        outline: none;
        border-color: var(--accent-color);
        box-shadow: 0 0 0 2px rgba(var(--accent-color-rgb), 0.1);
    }

    .roadmap-filters {
        display: flex;
        gap: 0.75rem;
    }

    .filter-group {
        display: flex;
        gap: 0.75rem;
    }

    .filter-select {
        padding: 0.75rem 1rem;
        border: 1px solid var(--border-color);
        border-radius: 8px;
        background: var(--bg-white);
        font-size: 0.875rem;
        min-width: 140px;
        cursor: pointer;
        transition: all 0.2s ease;
    }

    .filter-select:focus {
        outline: none;
        border-color: var(--accent-color);
        box-shadow: 0 0 0 2px rgba(var(--accent-color-rgb), 0.1);
    }

    .vote-button {
        display: flex;
        align-items: center;
        gap: 0.25rem;
        padding: 0.25rem 0.75rem;
        border: 1px solid var(--border-color);
        border-radius: 4px;
        background: var(--bg-white);
        color: var(--text-secondary);
        cursor: pointer;
        transition: all 0.2s ease;
    }

    .vote-button:disabled {
        opacity: 0.8;
        cursor: not-allowed;
        background: var(--bg-gray);
    }


    .vote-button.voted {
        background: var(--accent-color);
        border-color: var(--accent-color);
        color: white;
    }

    .vote-button.voted-down {
        background: var(--danger-color);
        border-color: var(--danger-color);
    }

    .vote-count {
        font-size: 0.875rem;
        font-weight: 500;
    }

    /* Modal Styles */
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

    .comment-form {
        display: flex;
        flex-direction: column;
        gap: 1rem;
    }

    .comment-input-group {
        display: flex;
        gap: 1rem;
    }

    .comment-input {
        flex: 1;
        padding: 0.75rem;
        border: 1px solid var(--border-color);
        border-radius: 6px;
        font-size: 0.875rem;
        resize: vertical;
        min-height: 38px;
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

    .comment-submit:hover {
        background: var(--accent-color-dark);
    }

    .comment-submit:disabled {
        background: var(--border-color);
        cursor: not-allowed;
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

    /* Icon Colors and Styles */
    #in-review-column .fa-magnifying-glass {
        color: #9333ea;
    }

    #planned-column .fa-clock {
        color: #0ea5e9;
    }

    #in-progress-column .fa-spinner {
        color: #f59e0b;
        animation: spin 10s linear infinite;
    }

    #complete-column .fa-check {
        color: #22c55e;
    }

    .modal-close .fa-times {
        color: #ef4444;
        transition: transform 0.2s ease;
    }

    .modal-close:hover .fa-times {
        transform: rotate(90deg);
    }

    @keyframes spin {
        from {
            transform: rotate(0deg);
        }
        to {
            transform: rotate(360deg);
        }
    }

    /* Enhance icon sizes and spacing */
    .roadmap-title i {
        font-size: 1.1em;
        margin-right: 8px;
    }

    .modal-close i {
        font-size: 1.2em;
    }

    @media (max-width: 1200px) {
        .roadmap {
            grid-template-columns: repeat(2, 1fr);
            height: auto;
        }

    }

    @media (max-width: 768px) {
        .roadmap {
            grid-template-columns: 1fr;
        }

        .roadmap-controls {
            flex-direction: column;
        }

        .roadmap-search,
        .roadmap-filters {
            width: 100%;
        }

        .roadmap-filters {
            justify-content: space-between;
        }

        .filter-group {
            flex-direction: column;
        }

        .filter-select {
            flex: 1;
        }
    }

    /* Nav and Header Styles */
    .nav-logo {
        display: flex;
        align-items: center;
        gap: 8px;
        font-weight: 600;
    }

    .nav-logo::before {
        content: '\f0c2';  /* Cloud icon */
        font-family: 'Font Awesome 6 Free';
        font-weight: 900;
        font-size: 1.2em;
        color: #3b82f6;
        margin-right: 4px;
    }

    .section-header {
        display: flex;
        align-items: center;
        margin: 2rem 0;
        padding-bottom: 1rem;
        border-bottom: 2px solid var(--border-color);
    }

    .section-title {
        font-size: 1.5rem;
        font-weight: 600;
        color: var(--text-primary);
        display: flex;
        align-items: center;
        gap: 0.5rem;
    }

    .section-title::before {
        content: '\f7a9';  /* Route icon */
        font-family: 'Font Awesome 6 Free';
        font-weight: 900;
        color: #3b82f6;
    }
</style>
</head>
<?php require_once __DIR__ . '/common/top.php';?>
<div class="section-header">
    <h2 class="section-title">Product Roadmap</h2>
</div>

<div class="roadmap-controls">
    <div class="roadmap-search">
        <input type="text" id="roadmapSearch" placeholder="Search roadmap items...">
    </div>
    <div class="roadmap-filters">
        <div class="filter-group">
            <select id="quarterFilter" class="filter-select">
                <option value="">All Quarters</option>
                <option value="Q1">Q1</option>
                <option value="Q2">Q2</option>
                <option value="Q3">Q3</option>
                <option value="Q4">Q4</option>
            </select>
            <select id="yearFilter" class="filter-select">
                <option value="">All Years</option>
                <option value="2024">2024</option>
                <option value="2025">2025</option>
            </select>
        </div>
    </div>
</div>

<div class="roadmap">
    <!-- In Review Column -->
    <div class="roadmap-column" id="in-review-column">
        <div class="roadmap-header">
            <h3 class="roadmap-title">
                <i class="fa-solid fa-magnifying-glass"></i>
                In Review
                <span class="roadmap-count">0 items</span>
            </h3>
        </div>
        <div class="roadmap-items"></div>
    </div>

    <!-- Planned Column -->
    <div class="roadmap-column" id="planned-column">
        <div class="roadmap-header">
            <h3 class="roadmap-title">
                <i class="fa-regular fa-clock"></i>
                Planned
                <span class="roadmap-count">0 items</span>
            </h3>
        </div>
        <div class="roadmap-items"></div>
    </div>

    <!-- In Progress Column -->
    <div class="roadmap-column" id="in-progress-column">
        <div class="roadmap-header">
            <h3 class="roadmap-title">
                <i class="fa-solid fa-spinner"></i>
                In Progress
                <span class="roadmap-count">0 items</span>
            </h3>
        </div>
        <div class="roadmap-items"></div>
    </div>

    <!-- Completed Column -->
    <div class="roadmap-column" id="complete-column">
        <div class="roadmap-header">
            <h3 class="roadmap-title">
                <i class="fa-solid fa-check"></i>
                Completed
                <span class="roadmap-count">0 items</span>
            </h3>
        </div>
        <div class="roadmap-items"></div>
    </div>
</div>

<!-- Modal Dialog -->
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
                <div class="modal-info-item">
                    <div class="modal-info-label">Description</div>
                    <div class="modal-info-value description"></div>
                </div>
                <div class="modal-info-item">
                    <div class="modal-info-label">Priority</div>
                    <div class="modal-info-value priority"></div>
                </div>
                <div class="modal-info-item">
                    <div class="modal-info-label">Progress</div>
                    <div class="modal-info-value progress"></div>
                </div>
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
<?php require_once __DIR__ . '/common/bottom.php';?>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        const modal = document.getElementById('itemModal');
        
        // Close modal when clicking outside
        window.addEventListener('click', function(event) {
            if (event.target === modal) {
                closeModal();
            }
        });
    });

    const roadmapSearch = document.getElementById("roadmapSearch");
    const quarterFilter = document.getElementById("quarterFilter");
    const yearFilter = document.getElementById("yearFilter");
    let roadmapData = {};

    // Vote tracking in localStorage
    const VOTE_STORAGE_KEY = 'roadmap_votes';
    const VOTE_CLICKS_KEY = 'roadmap_vote_clicks';
    
    // Initialize vote storage if not exists
    if (!localStorage.getItem(VOTE_STORAGE_KEY)) {
        localStorage.setItem(VOTE_STORAGE_KEY, JSON.stringify({}));
    }
    if (!localStorage.getItem(VOTE_CLICKS_KEY)) {
        localStorage.setItem(VOTE_CLICKS_KEY, JSON.stringify({}));
    }

    // Get stored votes
    function getStoredVotes() {
        return JSON.parse(localStorage.getItem(VOTE_STORAGE_KEY) || '{}');
    }

    // Get stored click counts
    function getVoteClicks() {
        return JSON.parse(localStorage.getItem(VOTE_CLICKS_KEY) || '{}');
    }

    // Update stored votes
    function updateStoredVote(itemId, voteState) {
        const votes = getStoredVotes();
        votes[itemId] = voteState;
        localStorage.setItem(VOTE_STORAGE_KEY, JSON.stringify(votes));
    }

    // Update click counts
    function updateVoteClicks(itemId) {
        const clicks = getVoteClicks();
        clicks[itemId] = (clicks[itemId] || 0) + 1;
        localStorage.setItem(VOTE_CLICKS_KEY, JSON.stringify(clicks));
        return clicks[itemId];
    }

    // Check if voting is allowed
    function canVote(itemId) {
        const clicks = getVoteClicks();
        return !clicks[itemId] || clicks[itemId] < 3;
    }

    // Function to format date
    function formatDate(dateString) {
        const date = new Date(dateString);
        return date.toLocaleDateString('en-US', {
            year: 'numeric',
            month: 'short',
            day: 'numeric'
        });
    }

    // Function to create a roadmap item
    function createRoadmapItem(item) {
        const itemElement = document.createElement('div');
        itemElement.className = 'roadmap-item';
        itemElement.dataset.quarter = item.launchDate ? new Date(item.launchDate).getFullYear() + '-Q' + (Math.floor(new Date(item.launchDate).getMonth() / 3) + 1) : '';
        itemElement.dataset.priority = item.priority ? item.priority.toLowerCase() : '';
        itemElement.onclick = () => openModal(item);

        // Get stored vote state
        const storedVotes = getStoredVotes();
        const voteState = storedVotes[item.id] || 'none';

        itemElement.innerHTML = `
            <h4 class="roadmap-item-title">${item.title}</h4>
            <p class="roadmap-item-description">${item.description || ''}</p>
            <div class="roadmap-tags">
                ${item.launchDate ? `<span class="roadmap-tag">Launch: ${formatDate(item.launchDate)}</span>` : ''}
                ${item.priority ? `<span class="roadmap-tag">${item.priority} Priority</span>` : ''}
                ${item.tags ? item.tags.map(tag => `<span class="roadmap-tag">${tag}</span>`).join('') : ''}
            </div>
            <div class="roadmap-meta">
                <button class="vote-button${voteState === 'up' ? ' voted' : (voteState === 'down' ? ' voted-down' : '')}" 
                        onclick="toggleVote(event, this)" 
                        data-id="${item.id}" 
                        data-vote-state="${voteState}"
                        ${!canVote(item.id) ? 'disabled' : ''}>
                    <i class="fa-solid fa-caret-up"></i>
                    <span class="vote-count">${item.likes || 0}</span>
                </button>
                ${item.progress ? `<span class="roadmap-tag">Progress: ${item.progress}%</span>` : ''}
            </div>
        `;

        return itemElement;
    }

    // Modal functions
    function openModal(item) {
        const modal = document.getElementById('itemModal');
        const title = modal.querySelector('.modal-title');
        const description = modal.querySelector('.description');
        const priority = modal.querySelector('.priority');
        const progress = modal.querySelector('.progress');
        const commentsList = modal.querySelector('.comments-list');
        const commentItemId = modal.querySelector('#commentItemId');
        const successNotification = modal.querySelector('#successNotification');
        const errorNotification = modal.querySelector('#errorNotification');

        // Reset notifications
        successNotification.style.display = 'none';
        errorNotification.style.display = 'none';

        title.textContent = item.title;
        description.textContent = item.description || 'No description available';
        priority.textContent = item.priority || 'Not set';
        progress.textContent = item.progress ? `${item.progress}%` : 'Not started';
        commentItemId.value = item.id;

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

        // Hide any existing notifications
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
                
                if (result.status === 'ok' && result.data) {
                    // Find the updated item in all sections
                    const allItems = [
                        ...(result.data['in-progress'] || []),
                        ...(result.data.complete || []),
                        ...(result.data.planned || [])
                    ];
                    
                    const item = allItems.find(item => item.id === itemId);
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
                
                // Refresh the roadmap
                await renderRoadmap();
            } else {
                // Show error notification
                errorNotification.style.display = 'block';
            }
        } catch (error) {
            console.error('Error:', error);
            // Show error notification
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

    // Handle voting
    window.toggleVote = function(event, button) {
        event.stopPropagation();
        const itemId = button.dataset.id;
        
        // Check if voting is allowed
        if (!canVote(itemId)) {
            console.log('Voting limit reached for this item');
            return;
        }

        const voteCount = button.querySelector(".vote-count");
        const currentVotes = parseInt(voteCount.textContent);
        const currentState = button.dataset.voteState;

        let newState;
        let endpoint;

        // Determine the new state and endpoint based on current state
        if (currentState === 'none') {
            newState = 'up';
            endpoint = 'like';
            button.classList.add('voted');
            button.classList.remove('voted-down');
            voteCount.textContent = currentVotes + 1;
        } else if (currentState === 'up') {
            newState = 'down';
            endpoint = 'dislike';
            button.classList.remove('voted');
            button.classList.add('voted-down');
            voteCount.textContent = currentVotes - 1;
        } else {
            newState = 'none';
            endpoint = 'like';
            button.classList.remove('voted');
            button.classList.remove('voted-down');
            voteCount.textContent = currentVotes;
        }

        // Update click count
        const clicks = updateVoteClicks(itemId);
        if (clicks >= 3) {
            button.disabled = true;
        }

        // Update the button's state
        button.dataset.voteState = newState;
        updateStoredVote(itemId, newState);

        // Send request to server
        fetch(`/roadmap_api/${endpoint}/`, {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
            },
            body: JSON.stringify({
                itemId: itemId
            })
        }).catch(error => {
            console.error("Error:", error);
            // Revert UI changes if request fails
            button.classList.remove('voted', 'voted-down');
            button.dataset.voteState = currentState;
            updateStoredVote(itemId, currentState);
            voteCount.textContent = currentVotes;
        });
    }

    // Function to load and render roadmap data
    function loadRoadmap() {
        fetch('/roadmap_api/')
            .then(response => response.json())
            .then(result => {
                if (result.status === 'ok') {
                    roadmapData = result.data;
                    renderRoadmap();
                } else {
                    console.error('Error loading roadmap:', result.message);
                }
            })
            .catch(error => {
                console.error('Error fetching roadmap data:', error);
            });
    }

    // Function to render roadmap items
    function renderRoadmap() {
        const columns = {
            'in-review': document.querySelector('#in-review-column .roadmap-items'),
            'planned': document.querySelector('#planned-column .roadmap-items'),
            'in-progress': document.querySelector('#in-progress-column .roadmap-items'),
            'complete': document.querySelector('#complete-column .roadmap-items')
        };

        // Clear existing items
        Object.values(columns).forEach(column => column.innerHTML = '');

        // Filter and render items
        const searchTerm = roadmapSearch.value.toLowerCase();
        const quarter = quarterFilter.value;
        const year = yearFilter.value;

        Object.entries(roadmapData).forEach(([status, items]) => {
            const column = columns[status];
            if (!column) return;

            let visibleCount = 0;
            items.forEach(item => {
                const itemQuarter = item.launchDate ? new Date(item.launchDate).getFullYear() + '-Q' + (Math.floor(new Date(item.launchDate).getMonth() / 3) + 1) : '';
                const itemYear = item.launchDate ? new Date(item.launchDate).getFullYear() : '';
                const matchesSearch = item.title.toLowerCase().includes(searchTerm) || 
                                   (item.description && item.description.toLowerCase().includes(searchTerm));
                const matchesQuarter = !quarter || itemQuarter.includes(quarter);
                const matchesYear = !year || itemYear === year;

                if (matchesSearch && matchesQuarter && matchesYear) {
                    column.appendChild(createRoadmapItem({ ...item, status }));
                    visibleCount++;
                }
            });

            // Update count
            const countElement = column.closest('.roadmap-column').querySelector('.roadmap-count');
            countElement.textContent = `${visibleCount} item${visibleCount !== 1 ? 's' : ''}`;
        });
    }

    // Event listeners for filters
    roadmapSearch.addEventListener("input", renderRoadmap);
    quarterFilter.addEventListener("change", renderRoadmap);
    yearFilter.addEventListener("change", renderRoadmap);

    // Initial load
    loadRoadmap();
</script>

<?php require_once __DIR__ . '/common/footer.php';?>