class TourismChatbot {
    constructor() {
        this.chatMessages = document.getElementById('chatMessages');
        this.chatInput = document.getElementById('chatInput');
        this.sendBtn = document.getElementById('sendBtn');
        this.typingIndicator = document.getElementById('typingIndicator');
        this.quickActions = document.getElementById('quickActions');
        this.currentLanguage = 'vi';
        
        this.initializeEventListeners();
        this.updateQuickActions();
    }

    initializeEventListeners() {
        // Send button click
        this.sendBtn.addEventListener('click', () => this.sendMessage());
        
        // Enter key press
        this.chatInput.addEventListener('keypress', (e) => {
            if (e.key === 'Enter' && !e.shiftKey) {
                e.preventDefault();
                this.sendMessage();
            }
        });

        // Language switch
        document.querySelectorAll('.language-btn').forEach(btn => {
            btn.addEventListener('click', (e) => {
                this.switchLanguage(e.target.dataset.lang);
            });
        });

        // Quick actions
        this.quickActions.addEventListener('click', (e) => {
            if (e.target.classList.contains('quick-btn')) {
                const message = e.target.dataset.message;
                this.chatInput.value = message;
                this.sendMessage();
            }
        });

        // Auto-resize input
        this.chatInput.addEventListener('input', () => {
            this.sendBtn.disabled = !this.chatInput.value.trim();
        });
    }

    switchLanguage(lang) {
        this.currentLanguage = lang;
        
        // Update active button
        document.querySelectorAll('.language-btn').forEach(btn => {
            btn.classList.toggle('active', btn.dataset.lang === lang);
        });

        // Update placeholders and texts
        if (lang === 'en') {
            this.chatInput.placeholder = 'Type your question...';
        } else {
            this.chatInput.placeholder = 'Nhập câu hỏi của bạn...';
        }

        this.updateQuickActions();
    }

    updateQuickActions(destinationName = null) {
        const actions = [
            { intent: 'destinations', text: this.currentLanguage === 'vi' ? '🏖️ Điểm đến' : '🏖️ Destinations' },
            { intent: 'restaurants', text: this.currentLanguage === 'vi' ? '🍽️ Nhà hàng' : '🍽️ Restaurants' },
            { intent: 'hotels', text: this.currentLanguage === 'vi' ? '🏨 Khách sạn' : '🏨 Hotels' },
            { intent: 'attractions', text: this.currentLanguage === 'vi' ? '🏖️ Tham quan' : '🏖️ Attractions' },
            { intent: 'english', text: this.currentLanguage === 'vi' ? '🌐 English' : '🌐 Vietnamese' }
        ];

        this.quickActions.innerHTML = actions.map(action => {
            let msg = "";
            if (destinationName) {
                if (action.intent === "destinations") {
                    msg = this.currentLanguage === 'vi' ? "Gợi ý điểm đến du lịch" : "Suggest tourist destinations";
                } else if (action.intent === "restaurants") {
                    msg = this.currentLanguage === 'vi' ? `Nhà hàng ở ${destinationName}` : `Restaurants in ${destinationName}`;
                } else if (action.intent === "hotels") {
                    msg = this.currentLanguage === 'vi' ? `Khách sạn ở ${destinationName}` : `Hotels in ${destinationName}`;
                } else if (action.intent === "attractions") {
                    msg = this.currentLanguage === 'vi' ? `Điểm tham quan ở ${destinationName}` : `Attractions in ${destinationName}`;
                } else if (action.intent === "english") {
                    msg = this.currentLanguage === 'vi' ? "English" : "Vietnamese";
                }
            } else {
                // generic khi chưa có context
                if (action.intent === "restaurants") msg = this.currentLanguage === 'vi' ? "Nhà hàng" : "Restaurants";
                else if (action.intent === "hotels") msg = this.currentLanguage === 'vi' ? "Khách sạn" : "Hotels";
                else if (action.intent === "attractions") msg = this.currentLanguage === 'vi' ? "Điểm tham quan" : "Attractions";
                else if (action.intent === "destinations") msg = this.currentLanguage === 'vi' ? "Gợi ý điểm đến du lịch" : "Suggest tourist destinations";
                else if (action.intent === "english") msg = this.currentLanguage === 'vi' ? "English" : "Vietnamese";
            }

            return `<button class="quick-btn" data-intent="${action.intent}" data-message="${msg}">${action.text}</button>`;
        }).join('');
    }

    async sendMessage() {
        const message = this.chatInput.value.trim();
        if (!message) return;

        // Add user message
        this.addMessage(message, 'user');
        this.chatInput.value = '';
        this.sendBtn.disabled = true;

        // Show typing indicator
        this.showTyping();

        try {
            // Send to backend
            const response = await fetch('/api/chat', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ 
                    message: message,
                    language: this.currentLanguage 
                })
            });

            const data = await response.json();
            
            if (response.ok) {
                // Update language if changed
                if (data.language !== this.currentLanguage) {
                    this.switchLanguage(data.language);
                }

                this.addMessage(data.response, 'bot');

                // ✅ Cập nhật quick actions theo current_destination
                if (data.current_destination) {
                    const destRes = await fetch(`/api/destination/${data.current_destination}?lang=${data.language}`);
                    const destDetails = await destRes.json();
                    if (destDetails && destDetails.destination) {
                        this.updateQuickActions(destDetails.destination.name);
                    }
                } else {
                    // chưa chọn địa điểm nào → generic
                    this.updateQuickActions();
                }

            } else {
                this.addMessage(
                    data.error || 'Có lỗi xảy ra. Vui lòng thử lại.',
                    'bot',
                    true
                );
            }

        } catch (error) {
            console.error('Error:', error);
            this.addMessage(
                this.currentLanguage === 'vi' ? 
                'Không thể kết nối đến server. Vui lòng thử lại.' :
                'Cannot connect to server. Please try again.',
                'bot',
                true
            );
        } finally {
            this.hideTyping();
            this.sendBtn.disabled = false;
        }
    }

    addMessage(content, sender, isError = false) {
        const messageDiv = document.createElement('div');
        messageDiv.className = `message ${sender}`;
        
        const avatarDiv = document.createElement('div');
        avatarDiv.className = 'message-avatar';
        avatarDiv.innerHTML = sender === 'user' ? '<i class="fas fa-user"></i>' : '<i class="fas fa-robot"></i>';
        
        const contentDiv = document.createElement('div');
        contentDiv.className = 'message-content';
        if (isError) {
            contentDiv.classList.add('error-message');
        }
        
        // Format content with basic markdown support
        let formattedContent = content
            .replace(/\*\*(.*?)\*\*/g, '<strong>$1</strong>')
            .replace(/\n/g, '<br>');
        
        contentDiv.innerHTML = formattedContent;
        
        messageDiv.appendChild(avatarDiv);
        messageDiv.appendChild(contentDiv);
        
        this.chatMessages.appendChild(messageDiv);
        this.scrollToBottom();
    }

    showTyping() {
        this.typingIndicator.style.display = 'flex';
        this.scrollToBottom();
    }

    hideTyping() {
        this.typingIndicator.style.display = 'none';
    }

    scrollToBottom() {
        setTimeout(() => {
            this.chatMessages.scrollTop = this.chatMessages.scrollHeight;
        }, 100);
    }
}

// Initialize chatbot when page loads
document.addEventListener('DOMContentLoaded', () => {
    new TourismChatbot();
});