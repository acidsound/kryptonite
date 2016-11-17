Template.chat.onCreated ->
	@roomId = new ReactiveVar
Template.chat.helpers
	"rooms": ->
		Rooms.find {},
			sort:
				createdAt: -1
	"roomId": ->
		Template.instance().roomId.get()
	"room": ->
		Rooms.findOne Template.instance().roomId.get()
	"chats": ->
		Chats.find
			roomId: Template.instance().roomId.get()
		,
			sort:
				createdAt: -1
	"isMine": ->
		@owner is Meteor.userId()
Template.chat.events
	"click #btn-create-room": ->
		Meteor.call "room.add"
	"click .rooms .remove": ->
		Meteor.call "room.remove", @
	"click .rooms .room": (_, t)->
		t.roomId.set @_id
	"click #leave": (_, t) ->
		t.roomId.set undefined
	"submit .message": (e, t)->
		console.log 'message submit'
		Meteor.call "chat.add", 
			roomId: t.roomId.get()
			message: e.target.message?.value
		,
			(err,result)=>
				unless err
					e.target.message?.value = ''
		false
