class Building
	constructor: (@name, @cost, @modifier) ->
		@cost
		@description
		@modifier
		@amount : 0
	purchase: -> 
		if potatoCount > calculatePrice()
			amount+=1
			potatoCount-=@cost
		else console.log("KAPPA")
	calculatePrice: ->
		@cost = @cost*1.15
		return @cost
	getMod: ->
		return modifier

upgradeInsert = (price, cost, modifier) ->
	type = new Building(type, 10, 2)
	temp.purchase()



		