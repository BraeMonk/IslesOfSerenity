Isles of Serenity - Phase 1 Prototype (Godot 4)

1. Open Godot 4.
2. Choose 'Import' and select the 'project.godot' file in this folder.
3. In Project Settings -> Autoload, add:
   Path: res://Singletons/Inventory.gd
   Name: Inventory
   Check 'Enable' and press 'Add'.
4. Set up a simple TileSet for the 'Ground' TileMap:
   - At least one tile for water (ID 0)
   - One tile for grass (ID 1)
5. Run the project.

Controls:
- WASD / Arrow keys to move.
- E to interact/harvest nearby resource nodes.

You should spawn on a circular island with some scattered resources and
see your inventory update as you harvest them.
