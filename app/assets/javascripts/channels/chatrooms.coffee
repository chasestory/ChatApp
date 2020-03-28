App.chatrooms = App.cable.subscriptions.create "ChatroomsChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    today_date = new Date().toLocaleDateString(undefined, {
        day: '2-digit',
        month: '2-digit',
        year: 'numeric'
    })
    today_time = new Date().toLocaleTimeString(undefined, {
        hour: '2-digit',
        minute: '2-digit'
    })
    active_chatroom = $("[data-behavior='messages'][data-chatroom-id='#{data.chatroom_id}']")
    if active_chatroom.length > 0
      
      if document.hidden 

        if $(".strike").length == 0 
          active_chatroom.append("<div class='strike'><span>Unread Messages</span></div>")

        if Notification.permission == "granted"
          new Notification(data.username, {body: data.body})

      else
        App.last_read.update(data.chatroom_id)
      active_chatroom.append("<div align='left'><span><i class='times' style='margin-left:3px; margin-right:3px;'>#{today_date}</i><i class='times' style='margin-right:7px;'>#{today_time}</i></span><span style='border-right:1px solid black;'></span><strong style='margin-left:5px;'>#{data.username}:</strong> #{data.body}</div>")
      console.log today_date, today_time
    else
      $("[data-behavior='chatroom-link'][data-chatroom-id='#{data.chatroom_id}']").css("font-weight", "bold")
  
  send_message: (chatroom_id, message) ->
    @perform "send_message", {chatroom_id: chatroom_id, body: message}
