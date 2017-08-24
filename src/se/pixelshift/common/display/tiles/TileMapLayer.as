/**
 * Created by black on 2016-05-15.
 */
package se.pixelshift.common.display.tiles
{
	import se.pixelshift.common.display.tiles.TileMapData;

	import starling.display.Image;
	import starling.display.MeshBatch;
	import starling.textures.Texture;

	public class TileMapLayer extends MeshBatch
	{
		private var _data:Vector.<Vector.<TileMapData>>;
		private var _tiles:Vector.<Texture>;
		private var _tex:Texture;
		private var _size:uint;

		public function TileMapLayer(tileSize:uint, tileData:Vector.<Vector.<TileMapData>>, tileTextures:Vector.<Texture>)
		{
			_size = tileSize;
			_data = tileData;
			_tiles = tileTextures;
		}

		public function get data():Vector.<Vector.<TileMapData>>
		{
			return _data;
		}

		public function set data(value:Vector.<Vector.<TileMapData>>):void
		{
			_data = value;

			updateTiles();
		}

		private function updateTiles():void
		{
			for (var x:uint = 0; x < _data.length; x++)
			{
				for (var y:uint = 0; y < _data[x].length; y++)
				{
					var img:Image = new Image(_tiles[_data[x][y].index]);
					img.x = x * _size;
					img.y = y * _size;
					addMesh(img);
				}
			}
		}
	}
}
