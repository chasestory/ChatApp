import consumer from "./consumer"

consumer.subscriptions.subscriptions.create("ChatroomsChannel", {
	connected() {},
	disconnected() {},
	received(data) {
		var active_chatroom, today_date, today_time;
		today_date = new Date().toLocaleDateString(void 0, {
			day: '2-digit',
			month: '2-digit',
			year: 'numeric'
		});
		today_time = new Date().toLocaleTimeString(void 0, {
			hour: '2-digit',
			minute: '2-digit'
		});
		active_chatroom = $("[data-behavior='messages'][data-chatroom-id='" + data.chatroom_id + "']");
		if (active_chatroom.length > 0) {
			if (document.hidden) {
				if ($(".strike").length === 0) {
					active_chatroom.append("<div class='strike'><span>Unread Messages</span></div>");
				}
				if (Notification.permission === "granted") {
					new Notification(data.username, {
						body: data.body
					});
				}
			} else {
				App.last_read.update(data.chatroom_id);
			}
			return active_chatroom.append("<div align='left'><span><i class='times' style='margin-left:3px; margin-right:3px;'>" + today_date + "</i><i class='times' style='margin-right:7px;'>" + today_time + "</i></span><span style='border-right:1px solid black;'></span><strong style='margin-left:5px;'>" + data.username + ":</strong> " + data.body + "</div>");
		} else {
			return $("[data-behavior='chatroom-link'][data-chatroom-id='" + data.chatroom_id + "']").css("font-weight", "bold");
		}
	},
	send_message(chatroom_id, message) {
		return this.perform("send_message", {
			chatroom_id: chatroom_id,
			body: message
		});
	}
});
