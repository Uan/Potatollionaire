initMagic = ->
  spells["golem"] = new SummonGolem
class Spell
  constructor: (@name) ->
    @description
    @cost
    @duration
    duration_cur :  0
  effect: =>
    @tick()
  expiration: =>
    @duration_cur=0 
  tick: =>
    if @duration_cur > 0
      @duration_cur -= 1
      setTimeout(@tick,1000)
    else @expiration()
  cast: =>
    unless mana<@cost && @duration_cur>0
      @duration_cur = @duration
      mana -=@cost
      @effect()
      

class SummonGolem extends Spell
  constructor: ->
    super("golem")
  description: "summon potato golem to boost your production"
  cost: 10
  duration: 60
  effect: =>
    super
    magicMultiplier +=0.15
  expiration: =>
    magicMultiplier -=0.15

sacrifice = (n) ->
  unless potatoCount<n
    mana+=n
    potatoCount-=n 