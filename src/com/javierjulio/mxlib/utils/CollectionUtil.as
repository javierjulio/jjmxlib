package com.javierjulio.mxlib.utils
{
	import mx.collections.ArrayCollection;
	import mx.collections.ICollectionView;
	import mx.collections.IList;
	import mx.collections.XMLListCollection;
	
	/**
	 * The CollectionUtil class is used by classes to enable the ability to 
	 * retrieve an item by an id field.
	 */
	public class CollectionUtil
	{
		//--------------------------------------------------------------------------
		//
		//  Class methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * Returns an item by id from an IList if any was found.
		 * 
		 * @param collection The list in which to find the item.
		 * 
		 * @param idField The field in the data item that contains the id.
		 * 
		 * @param id The id of the item to be retrieved.
		 * 
		 * @return The object found by id. Returns null if no match.
		 */
		public static function getItemById(collection:IList, idField:String, id:String):Object 
		{
			var result:Object;
			
			if (collection == null || idField == null) 
				return result;
			
			var item:Object;
			var numItems:int = collection.length;
			
			for (var i:int = 0; i < numItems; i++) 
			{
				item = collection.getItemAt(i);
				
				if (item && item[idField] == id) 
				{
					result = item;
					break;
				}
			}
			
			return result;
		}
		
		/**
		 * Returns the index of the item by an item's id from the list if found.
		 * 
		 * @param collection The list in which to find the item index.
		 * 
		 * @param idField The property name of the item that contains the id value.
		 * 
		 * @param id The id value from which to retrieve the item.
		 * 
		 * @return The index of the item, or -1 if the item is not in the list.
		 */
		public static function getItemIndexById(collection:IList, idField:String, id:String):int 
		{
			var result:int = -1;
			
			if (collection == null || idField == null) 
				return result;
			
			var item:Object;
			var numItems:int = collection.length;
			
			for (var i:int = 0; i < numItems; i++) 
			{
				item = collection.getItemAt(i);
				
				if (item && item[idField] == id) 
				{
					result = i;
					break;
				}
			}
			
			return result;
		}
		
		/**
		 * Removes an item by the specified id and returns it. Any items that were 
		 * after this index are now one index earlier. Returns <code>null</code> if 
		 * no item was found by the id given.
		 * 
		 * @param collection The list in which to find the item.
		 * 
		 * @param idField The property name of the item that contains the id value.
		 * 
		 * @param id The id value from which to retrieve the item.
		 * 
		 * @return The removed item, or <code>null</code> if none was found.
		 */
		public static function removeItemById(collection:IList, idField:String, id:String):Object 
		{
			var result:Object;
			
			if (collection == null || idField == null) 
				return result;
			
			var item:Object = getItemById(collection, idField, id);
			
			if (item) 
			{
				var index:int = collection.getItemIndex(item);
				
				if (index >= 0 && index < collection.length) 
					result = collection.removeItemAt(index);
			}
			
			return result;
		}
	}
}