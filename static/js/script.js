let isTyping = false;

function handleKeyPress(event) {
    if (event.key === 'Enter' && !isTyping) {
        sendMessage();
    }
}

function sendExample(message) {
    document.getElementById('messageInput').value = message;
    sendMessage();
}

function addMessage(content, isUser = false) {
    const messagesContainer = document.getElementById('messages');
    const welcomeMessage = messagesContainer.querySelector('.welcome-message');
    
    if (welcomeMessage) {
        welcomeMessage.remove();
    }

    const messageDiv = document.createElement('div');
    messageDiv.className = `message ${isUser ? 'user' : 'bot'}`;
    
    const contentDiv = document.createElement('div');
    contentDiv.className = 'message-content';
    contentDiv.textContent = content;
    
    messageDiv.appendChild(contentDiv);
    messagesContainer.appendChild(messageDiv);
    
    messagesContainer.scrollTop = messagesContainer.scrollHeight;
}

function showTypingIndicator() {
    document.getElementById('typingIndicator').style.display = 'block';
    const messagesContainer = document.getElementById('messages');
    messagesContainer.scrollTop = messagesContainer.scrollHeight;
}

function hideTypingIndicator() {
    document.getElementById('typingIndicator').style.display = 'none';
}

function showStatus(message, isError = false) {
    const statusDiv = document.getElementById('status');
    statusDiv.textContent = message;
    statusDiv.className = `status ${isError ? 'error' : ''}`;
    statusDiv.style.display = 'block';
    
    setTimeout(() => {
        statusDiv.style.display = 'none';
    }, 3000);
}

//  Load chat history from server
function loadHistory() {
    fetch('/api/chat_history')
        .then(res => res.json())
        .then(data => {
            let historyDiv = document.getElementById("chat-history");
            historyDiv.innerHTML = "";
            data.forEach(chat => {
                historyDiv.innerHTML += `
                    <div class="chat-item">
                        <b>👤 User:</b> ${chat.user_message}<br>
                        <b>🤖 Bot:</b> ${chat.bot_response}<br>
                        <small>${chat.created_at}</small>
                        <hr>
                    </div>
                `;
            });
        });
}

// Clear chat history on server
function clearHistory() {
    fetch('/api/chat_history', { method: 'DELETE' })
        .then(res => res.json())
        .then(data => {
            alert(data.message);
            document.getElementById("chat-history").innerHTML = "";
        });
}

async function sendMessage() {
    if (isTyping) return;

    const messageInput = document.getElementById('messageInput');
    const sendButton = document.getElementById('sendButton');
    const message = messageInput.value.trim();

    if (!message) return;

    // Disable input
    isTyping = true;
    sendButton.disabled = true;
    sendButton.textContent = 'Đang gửi...';

    // Add user message
    addMessage(message, true);
    messageInput.value = '';

    // Show typing indicator
    showTypingIndicator();

    try {
        const response = await fetch('/api/chat', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({ message: message })
        });

        const data = await response.json();
        
        hideTypingIndicator();

        if (data.success) {
            addMessage(data.message);
            if (data.results_count > 0) {
                showStatus(`Đã tìm thấy ${data.results_count} kết quả liên quan`);
            }
        } else {
            addMessage(data.message || 'Đã xảy ra lỗi, vui lòng thử lại.');
            showStatus('Có lỗi xảy ra khi xử lý yêu cầu', true);
        }

    } catch (error) {
        console.error('Error:', error);
        hideTypingIndicator();
        addMessage('Xin lỗi, tôi không thể kết nối đến server. Vui lòng thử lại sau.');
        showStatus('Lỗi kết nối mạng', true);
    }

    // Enable input
    isTyping = false;
    sendButton.disabled = false;
    sendButton.textContent = 'Gửi';
    messageInput.focus();
}

// Check system health on load
async function checkHealth() {
    try {
        const response = await fetch('/api/health');
        const data = await response.json();
        
        if (data.success) {
            showStatus('Hệ thống đã sẵn sàng');
        } else {
            showStatus('Hệ thống gặp sự cố', true);
        }
    } catch (error) {
        showStatus('Không thể kết nối đến server', true);
    }
}

// Initialize
document.addEventListener('DOMContentLoaded', function() {
    checkHealth();
    document.getElementById('messageInput').focus();
});