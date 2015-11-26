upgrades=[]

initUpgrades = ->
  upgrades[0] = new Upgrade("test",->
    game.clickValue+=1
  ,->
    game.totalClicks>0
  ,->
    game.potatoCount-=10
  ,->
    game.potatoCount>=10
  )

class Upgrade
  constructor : (@name,@effect,@prereqs,@cost,@costCheck) ->
    @unlocked = false
    @purchased = false
  unlock: =>
    @unlocked = true if @prereqs()
  purchase : =>
    console.log(@)
    if @costCheck()
      @cost()
      @effect()
      @purchased = true
 # costCheck : ->