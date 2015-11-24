upgrades=[]

initUpgrades = ->
  upgrades[0] = new Upgrade("test",->
    clickValue+=1
  ,->
    totalClicks>0
  ,->
    potatoCount-=10
  ,->
    potatoCount>=10
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