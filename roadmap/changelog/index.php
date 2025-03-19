<?php
require_once __DIR__ . '/../../config.php';
require_once __DIR__ . '/../common/header.php';
?>
<style>
    /* Changelog Specific Styles */
    .changelog {
        max-width: 800px;
        margin: 0 auto;
        padding: 2rem 1rem;
        position: relative;
    }

    .changelog::before {
        content: '';
        position: absolute;
        top: 0;
        bottom: 0;
        left: calc(1rem + 24px);
        width: 2px;
        background: linear-gradient(180deg, 
            rgba(59, 130, 246, 0.5) 0%,
            rgba(59, 130, 246, 0.3) 50%,
            rgba(59, 130, 246, 0.1) 100%
        );
    }

    .changelog-version {
        margin-bottom: 3rem;
        padding: 1.5rem 1.5rem 1.5rem 3rem;
        background: var(--bg-white);
        border-radius: 12px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05),
                    0 1px 3px rgba(0, 0, 0, 0.1);
        position: relative;
        transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
        border: 1px solid rgba(59, 130, 246, 0.15);
        background: linear-gradient(
            to right bottom,
            rgba(255, 255, 255, 1),
            rgba(247, 249, 251, 0.8)
        );
        cursor: pointer;
    }

    .changelog-version::before {
        content: '';
        position: absolute;
        inset: 0;
        padding: 1px;
        background: linear-gradient(
            135deg,
            rgba(59, 130, 246, 0.2),
            rgba(59, 130, 246, 0.1) 20%,
            rgba(59, 130, 246, 0.05) 40%,
            transparent 60%
        );
        border-radius: inherit;
        -webkit-mask: 
            linear-gradient(#fff 0 0) content-box, 
            linear-gradient(#fff 0 0);
        -webkit-mask-composite: xor;
        mask-composite: exclude;
        pointer-events: none;
        transition: all 0.4s ease;
    }

    .changelog-version::after {
        content: '';
        position: absolute;
        left: -6px;
        top: 30px;
        width: 12px;
        height: 12px;
        background: #3b82f6;
        border-radius: 50%;
        z-index: 2;
        transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
        box-shadow: 0 0 10px rgba(59, 130, 246, 0.3);
    }

    .changelog-version:hover {
        transform: translateY(-4px) scale(1.01);
        box-shadow: 0 12px 24px rgba(59, 130, 246, 0.15),
                    0 4px 8px rgba(59, 130, 246, 0.1);
    }

    .changelog-version:hover::before {
        background: linear-gradient(
            135deg,
            rgba(59, 130, 246, 0.4),
            rgba(59, 130, 246, 0.2) 20%,
            rgba(59, 130, 246, 0.1) 40%,
            transparent 60%
        );
        padding: 2px;
    }

    .changelog-version:hover::after {
        transform: scale(1.5);
        box-shadow: 0 0 20px rgba(59, 130, 246, 0.5);
        background: #60a5fa;
    }

    /* Add smooth transition for child elements */
    .changelog-version * {
        transition: all 0.3s ease;
    }

    .changelog-version:hover h3 {
        color: #3b82f6;
        transform: translateX(4px);
    }

    .changelog-version:hover .version-date {
        color: #60a5fa;
    }

    .version-header {
        display: flex;
        align-items: center;
        justify-content: space-between;
        margin-bottom: 1.5rem;
        gap: 1rem;
    }

    .version-title {
        font-size: 1.25rem;
        font-weight: 600;
        color: var(--text-primary);
        margin: 0;
        position: relative;
        padding-left: 1.5rem;
    }

    .version-title::before {
        content: '\f0ae';
        font-family: 'Font Awesome 6 Free';
        font-weight: 900;
        position: absolute;
        left: 0;
        color: #3b82f6;
    }

    .version-date {
        color: #3b82f6;
        font-size: 0.875rem;
        font-weight: 500;
        padding: 0.35rem 1rem;
        background: rgba(59, 130, 246, 0.1);
        border-radius: 20px;
        white-space: nowrap;
        border: 1px solid rgba(59, 130, 246, 0.2);
    }

    .version-content {
        font-size: 0.95rem;
        line-height: 1.8;
        color: var(--text-primary);
        white-space: pre-wrap;
        position: relative;
        padding-left: 1.5rem;
    }

    .changelog-empty {
        text-align: center;
        padding: 4rem 2rem;
        color: var(--text-secondary);
        background: var(--bg-white);
        border-radius: 12px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
    }

    /* Loading State */
    .changelog-loading {
        text-align: center;
        padding: 4rem 2rem;
        color: var(--text-secondary);
    }

    .loading-spinner {
        display: inline-block;
        width: 2.5rem;
        height: 2.5rem;
        border: 2px solid rgba(59, 130, 246, 0.1);
        border-radius: 50%;
        border-top-color: #3b82f6;
        animation: spin 1s cubic-bezier(0.4, 0, 0.2, 1) infinite;
    }

    @keyframes spin {
        to {
            transform: rotate(360deg);
        }
    }

    @media (max-width: 640px) {
        .changelog::before {
            left: calc(1rem + 16px);
        }

        .changelog-version {
            margin-bottom: 2rem;
            padding: 1.25rem 1.25rem 1.25rem 2.5rem;
        }

        .changelog-version::before {
            width: 20px;
            height: 20px;
            left: -10px;
        }

        .changelog-version::after {
            width: 10px;
            height: 10px;
            left: -5px;
            top: 27px;
        }

        .version-header {
            flex-direction: column;
            align-items: flex-start;
            gap: 0.75rem;
        }

        .version-title {
            font-size: 1.1rem;
        }

        .version-date {
            font-size: 0.8rem;
        }

        .version-content {
            font-size: 0.9rem;
            line-height: 1.7;
        }
    }
</style>

<?php require_once __DIR__ . '/../common/top.php';?>

<div class="section-header">
    <h2 class="section-title"><i class="fa-solid fa-clock-rotate-left"></i> Changelog</h2>
</div>

<div class="changelog" id="changelogContainer">
    <div class="changelog-loading">
        <div class="loading-spinner"></div>
        <p>Loading changelog...</p>
    </div>
</div>
<?php require_once __DIR__ . '/../common/bottom.php';?>
<script>
    async function loadChangelog() {
        try {
            const response = await fetch('/roadmap_api/');
            const result = await response.json();
            
            const container = document.getElementById('changelogContainer');
            
            if (result.status === 'ok' && result.data && result.data.changelog) {
                if (result.data.changelog.length === 0) {
                    container.innerHTML = `
                        <div class="changelog-empty">
                            <p>No changelog entries available.</p>
                        </div>
                    `;
                    return;
                }

                // Sort changelog entries by date in descending order
                const sortedChangelog = result.data.changelog.sort((a, b) => {
                    return new Date(b.launchDate) - new Date(a.launchDate);
                });

                container.innerHTML = sortedChangelog.map(entry => `
                    <div class="changelog-version">
                        <div class="version-header">
                            <h3 class="version-title">${entry.title}</h3>
                            <span class="version-date">${formatDate(entry.launchDate)}</span>
                        </div>
                        <div class="version-content">${formatDescription(entry.description)}</div>
                    </div>
                `).join('');
            } else {
                throw new Error('Failed to load changelog data');
            }
        } catch (error) {
            console.error('Error:', error);
            document.getElementById('changelogContainer').innerHTML = `
                <div class="changelog-empty">
                    <p>Failed to load changelog. Please try again later.</p>
                </div>
            `;
        }
    }

    function formatDate(dateString) {
        const date = new Date(dateString);
        return date.toLocaleDateString('en-US', {
            year: 'numeric',
            month: 'long',
            day: 'numeric'
        });
    }

    function formatDescription(description) {
        if (!description) return 'No description available';
        
        // Escape HTML to prevent XSS
        const escaped = description
            .replace(/&/g, '&amp;')
            .replace(/</g, '&lt;')
            .replace(/>/g, '&gt;')
            .replace(/"/g, '&quot;')
            .replace(/'/g, '&#039;');
        
        // Convert emoji codes to actual emojis
        return escaped
            .replace(/\\u([0-9a-fA-F]{4})/g, (match, hex) => 
                String.fromCharCode(parseInt(hex, 16))
            );
    }

    // Load changelog when page loads
    document.addEventListener('DOMContentLoaded', loadChangelog);
</script>

<?php require_once __DIR__ . '/../common/footer.php';?>
