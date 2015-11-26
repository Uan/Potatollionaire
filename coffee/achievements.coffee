game.achievements = []
class Achievement
  constructor: (@name, @requirements, @description, @flavour_text) ->
    @unlocked = false
  tryUnlock: =>
    if @requirements() && !@unlocked
      console.log("achievement unlocked #{@name}")
      @unlocked = true
game.achievements[0] = new Achievement("test achievement", ->
  game.potatoCount > 0
, "yeah whatever", "dank reference goes here")
achievementCheck = ->
  for i in achievements
    i.tryUnlock unless i.unlocked


