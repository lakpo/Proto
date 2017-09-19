extends Node

func _ready():

    var grp = get_node("ButtonGroup")
    var zone = get_node("Panel/zone")

    var index = 0
    
    for itm in data.MAGASIN:
        var btn = Button.new()
        var text = itm.nom
        grp.add_child(btn)
        btn.set_text(itm.nom + ' (' + str(itm.price) + ')')
        btn.set_meta('name' , itm.nom)
        btn.set_meta('price' , itm.price)
        btn.set_meta('id' , index )
        index += 1
        
	
    grp.connect('button_selected',self,'price_selected')
    zone.connect('button_selected',self,'ele_selected')
    

func price_selected(button):
	var scene = load("res://Button.tscn")
	var meta = button.get_meta('name')
	var ele = scene.instance()
	ele.set_text(str(meta))
	var parent = get_node("Panel/zone")
	parent.add_child(ele)
	  
    #print(data.MAGASIN[meta].price)

func ele_selected(button):
	print('jesuisla')