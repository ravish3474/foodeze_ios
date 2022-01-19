class ApiEndpoint {

  static const String BASE_URL = "https://foodeze.co.za/android_api/flutter/customer_api.php";
  static const String BASE_URL2 = "https://foodeze.co.za/mobileapp_api_new/Api/placeOrder";
  static const String IMAGE_URL = "https://foodeze.co.za/mobileapp_api_new/";
  static const String MENU_ITEM_URL="https://foodeze.co.za/mobile_app_api_2/mobileapp_api/";
  static const String CATERING_MENU_ITEM_URL="https://foodeze.co.za/foodeze_new/restaurant/restaurant/uploads/";
  static const String CATERING_MENU_ITEM_URL_2="https://foodeze.co.za/mobile_app_api_2/mobileapp_api/";
  static const String EVENT_URL="https://foodeze.co.za/mobile_app_api_2/mobileapp_api/";
  static const String PLACEHOLDER_IMAGE_URL="https://socialistmodernism.com/wp-content/uploads/2017/07/placeholder-image.png?w=640";




  static const Map<String, String>  LOGIN = {'callback': "login"};
  static const Map<String, String>  UPDATE_PROFILE = {'callback': "updateUser"};
  static const Map<String, String>  KITCHEN_LIST = {'callback': "nearbySearch"};
  static const Map<String, String>  VIEW_CATEGORY = {'callback': "viewCategory"};
  static const Map<String, String>  FETCH_MENU = {'callback': "fetchMenu"};
  static const Map<String, String>  SEARCH_RESTAURANT = {'callback': "SearchRestaurant"};
  static const Map<String, String>  UPDATE_USER_IMAGE = {'callback': "updateProfilePic"};
  static const Map<String, String>  FETCH_NOTIFICATION = {'callback': "fetch_customer_notification"};
  static const Map<String, String>  FETCH_CUSTOMER_TICKETS = {'callback': "fetchCustomerTickets"};
  static const Map<String, String>  CREATE_TICKET = {'callback': "createTicket"};
  static const Map<String, String>  FETCH_VIEW_TICKET_CHAT = {'callback': "viewTicketChat"};
  static const Map<String, String>  ADD_CHAT_TO_TICKET = {'callback': "addChatToTicket"};
  static const Map<String, String>  FETCH_ALL_EVENS = {'callback': "FetchAllEvents"};
  static const Map<String, String>  FETCH_EVENT_TRANSACTION = {'callback': "fetchEventsTransactions"};
  static const Map<String, String>  CREATE_EVENT = {'callback': "create-event"};
  static const Map<String, String>  FETCH_CUSTOMERS_ORDER = {'callback': "fetchCustomerOrders"};
  static const Map<String, String>  addFavandUNfav = {'callback': "add_favourite"};
  static const Map<String, String>  fetchOrderStatus = {'callback': "fetch_order_status"};
  static const Map<String, String>  RATE_DRIVER = {'callback': "rateDriver"};
  static const Map<String, String>  RATE_VK = {'callback': "rateVk"};
  static const Map<String, String>  FETCH_ORDER_CHAT = {'callback': "fetch_order_chat"};
  static const Map<String, String>  CUSTOMER_RIDER_CHAT = {'callback': "customer_rider_chat"};
  static const Map<String, String>  ADD_ADDRESS = {'callback': "addAddress"};
  static const Map<String, String> FETCH_ADDRESSES = {'callback': "fetchAddress"};
  static const Map<String, String> DELETE_ADDRESS= {'callback': "deleteAddress"};
  static const Map<String, String> COUPON_CODE= {'callback': "couponcode"};
  static const Map<String, String> AVAILABLE_LOCATIONS= {'callback': "available_locations"};
  static const Map<String, String> FETCH_CATERING_RESTAURANT= {'callback': "fetchCateringRestaurant"};
  static const Map<String, String> FETCH_CATERING_MENU= {'callback': "fetchCateringMenu"};
  static const Map<String, String> SEND_CATERING_REQUEST= {'callback': "SendCateringRequest"};
  static const Map<String, String> FETCH_CATERING_REQUEST= {'callback': "FetchCateringRequest"};
  static const Map<String, String> DELETE_CATERING_REQUEST= {'callback': "deleteCateringRequest"};
  static const Map<String, String> VIEW_CATERING_DETAILS= {'callback': "viewCateringDetail"};
  static const Map<String, String> PAY_CATERING= {'callback': "payCatering"};
  static const Map<String, String> PAY_EVENT= {'callback': "events_booking"};
  static const Map<String, String> UPDATE_DEVICE_TOKEN= {'callback': "updateDeviceToken"};







}
