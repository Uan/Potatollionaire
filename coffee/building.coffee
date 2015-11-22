buildings = []
class Building
	constructor: (@name, @cost, @modifier) ->
		@built = false
		@cost
		@description
		@modifier
		@amount = 0
	purchase: -> 
		@built = true
		if potatoCount > calculatePrice()
			amount+=1
			potatoCount-=@cost
		else console.log("KAPPA")
	calculatePrice: ->
		@cost = @cost*1.15
		return @cost
	getMod: ->
		return modifier
	isBuilt: ->
		return @built
	getName: ->
		return @name
	getNum: ->
		return @amount
upgradeInsert = (type, cost, modifier) ->
	built = false
	for i in buildings
		if i.getName == type
			i.purchase
			built = true
	if !built
		temp = new Building(type, cost, modifier)
		temp.purchase()



		