package model
{
	import mx.collections.ArrayCollection;
	
	[Bindable]
	public class Employee
	{
		public var loaded:Boolean = false;
		
		public var id:int;
		public var firstName:String;
		public var lastName:String;
		public var title:String;
		public var department:String;
		public var city:String;
		public var email:String;
		public var officePhone:String;
		public var cellPhone:String;
		public var picture:String;
		
		private var _manager:Employee;
		
		// Lazy loading of manager
		[Bindable(event="managerChanged")]
		public function get manager():Employee
		{
			if (_manager && !_manager.loaded && _manager.id > 0)
			{
				var employeeSrv:EmployeeDAO = new EmployeeDAO();
				_manager = employeeSrv.getItem(_manager.id);
			}
			return _manager;
		}
		
		public function set manager(__manager:Employee):void
		{
			_manager = __manager;
			dispatchEvent(new Event("managerChanged"));
		}
		
		private var _directReports:ArrayCollection;
		private var directReportsLoaded:Boolean = false;
		
		// Lazy loading of the list of contacts
		[Bindable(event="contactsChanged")]
		public function get directReports():ArrayCollection
		{
			if (!directReportsLoaded && id > 0)
			{
				var employeeSrv:EmployeeDAO = new EmployeeDAO();
				_directReports = employeeSrv.findByManager(id);
				directReportsLoaded = true;
			}
			return _directReports;
		}
		
	}
}