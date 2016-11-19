@chance = new Chance()
Meteor.startup ->
	console.log "server initiated"
Meteor.methods
	"room.add": ( roomId = chance.word length:6)->
		check @userId, String
		Rooms.insert
			name: roomId
			createdAt: Date.now()
	"room.remove": ({_id})->
		check @userId, String
		check _id, String
		Rooms.remove _id
	"chat.add": ({roomId, message})->
		check @userId, String
		check roomId, String
		check message, String
		Chats.insert
			roomId: roomId
			message: message
			owner: @userId
			name: Meteor.user().username or 
				Meteor.user().emails[0].address.split('@')[0]
			createdAt: Date.now()
	"setUserPrivateKey": ({password})->
