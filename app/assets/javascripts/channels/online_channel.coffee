App.online = App.cable.subscriptions.create "OnlineChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    online = document.querySelector("#online-users")
    el = online.querySelector("[data-id='${data.id}']")

    if data.status == "online" && el == null
      online.insertAdjacentHTML('beforeend', data.html)

    if data.status == "offline" && el != null 
    	online.insertAdjacentHTML('beforeend', data.html)