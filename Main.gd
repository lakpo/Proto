extends Node

# On précharge la scène contant le boutton.
# Cet objet n'est pas créé, il est juste chargé en mémoire.
# On peut voir cette scène comme tant un moule qui nous permet
# de créer des objets de ce genre la en série.
const BUTTON_SCENE = preload("res://Button.tscn")

# En faisant un 'onready' on permet d'avoir ces 3 variables disponibles partout dans ce fichier
# Ainsi il n'est pas nécessaire de refaire les mêmes actions plusieurs fois.
onready var grp = get_node("ButtonGroup")
onready var zoneButtonGroup = get_node("Panel/ButtonGroup")
onready var zone = get_node("Panel/ButtonGroup/zone")

func _ready():
    var index = 0
    
    for itm in data.MAGASIN:
        var btn = Button.new()
        var text = '%s (%s)' % [itm.nom, itm.price]

        # Il est préférable de définir le texte, la texture et les meta informations d'un node
        # avant de l'ajouter a la scène. Car ajouter un node a une scène provoque un re-draw de ta scène
        # et a chaque modification du node, on effectue un re-draw de la scène.
        # Donc en faisant de cette manière, on économise 4 re-draw.
        btn.set_text(text)
        btn.set_meta('name', itm.nom)
        btn.set_meta('price', itm.price)
        btn.set_meta('id', index)

        grp.add_child(btn)

        index += 1
        
    
    grp.connect('button_selected', self, 'price_selected')

    # Le signal 'button_selected' est émis uniquement par un node de type 'ButtonGroup'
    # J'ai donc ajouté un node 'ButtonGroup' entre le Panel et la zone, ainsi tu peux écouter le bon signal
    zoneButtonGroup.connect('button_selected', self, 'ele_selected')
    

func price_selected(button):
    var meta = button.get_meta('name')

    # Depuis l'objet chargé en mémoire on crée un copie de cet objet
    # qui maintenant peut être ajouté a notre scène.
    var ele = BUTTON_SCENE.instance()

    ele.set_text(str(meta))

    zone.add_child(ele)

func ele_selected(button):
    var name = button.get_text()

    print('name: %s' % [name])
