buildings = []

class Building
	constructor: (@name, @cost, @modifier, @buttonID, @bDesc) ->
		@built = false
		@amount = 0
	purchase: ->	
		if  @getCost() <= potatoCount
			@built = true
			@amount+=1
			potatoCount-=@getCost()
			@increaseCost()
		else console.log("Not enough resources?")
	getMod: ->
		return @modifier
	isBuilt: ->
		return @built
	getName: ->
		return @name
	getCost: ->
		return @cost
	getNum: ->
		return @amount
	getButtonId: ->
		return @buttonID
	getDesc: ->
		return @bDesc
	increaseCost: ->
		@cost = @cost*1.15
	setMod: (number) ->
		@modifier = number
	placeholder: ->
		console.log "DO NOTHING"
#placeholder#changes are on the desktop. Adjusting the copy machien to the current code

buildingInsert = (type, cost, modifier, buttonID, bD) ->
	built = false
	unless buildings.length == 0
		for i in buildings
			if i.getName() == type
				i.purchase()
				built = true
	unless built
		temp = new Building(type, cost, modifier, buttonID, bD)
		console.log(temp.getCost())
		unless potatoCount < temp.getCost()
			buildings.push(temp)
			temp.purchase()



		