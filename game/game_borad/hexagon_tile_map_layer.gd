@tool
extends HexagonTileMapLayer

func _ready():
    super._ready()
    # Enable pathfinding
    pathfinding_enabled = true

    # Customize pathfinding weights (optional)
func _pathfinding_get_tile_weight(coords: Vector2i) -> float:
    # Return custom weight value (default is 1.0)
    return 1.0

    # Customize pathfinding connections (optional)
func _pathfinding_does_tile_connect(tile: Vector2i, neighbor: Vector2i) -> bool:
    # Return whether tiles should be connected (default is true)
    return true

    # Enable debug visualization (optional)
    debug_mode = DebugModeFlags.TILES_COORDS | DebugModeFlags.CONNECTIONS