<?php

namespace App\Http\Controllers\Api\V1;

use App\CPU\Helpers;
use App\Models\Order;
use App\Models\Account;
use App\Models\Product;
use App\Models\Shop;
use App\Models\Tank;

use App\Models\ProductNew;
use App\Models\Customer;
use App\Models\OrderDetail;
use App\Models\TransactionNew;
use App\Models\Transection;
use App\Models\TransferRecord;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use App\Models\BusinessSetting;
use function App\CPU\translate;
use App\Http\Controllers\Controller;
use App\Http\Resources\ProductsResource;
use App\Http\Resources\ShopsResource;
use App\Http\Resources\TanksResource;
use App\Http\Resources\TransactionNewsResource;

use App\Http\Resources\TransferRecordResource;

use App\Http\Resources\ProductNewsResource;

use Illuminate\Support\Facades\Validator;

class PosController extends Controller
{
    public function __construct(
        private Order $order,
        private Account $account,
        private Product $product,
        private Shop $shop,
        private Tank $tank,
        private ProductNew $productNew,
        private TransactionNew $transactionNew,
        private TransferRecord $transferRecord,
        private Customer $customer,
        private OrderDetail $order_detail,
        private Transection $transection,
        private BusinessSetting $business_setting,
    ){}
    /**
     * Display a listing of the resource.
     *
     * @param Request $request
     * @return JsonResponse
     */
    public function getProductIndex(Request $request): JsonResponse
    {
        $limit = $request['limit'] ?? 10;
        $offset = $request['offset'] ?? 1;
        $product = $this->product->latest()->paginate($limit, ['*'], 'page', $offset);
        $products = ProductsResource::collection($product);
        $data = [
            'total' => $products->total(),
            'limit' => $limit,
            'offset' => $offset,
            'products' => $products->items(),
        ];
        return response()->json($data, 200);
    }


    public function getShopIndex(Request $request): JsonResponse
    {
        $limit = $request['limit'] ?? 10;
        $offset = $request['offset'] ?? 1;
        $shop = $this->shop->latest()->paginate($limit, ['*'], 'page', $offset);
        $shops = ShopsResource::collection($shop);
        $data = [
            'total' => $shops->total(),
            'limit' => $limit,
            'offset' => $offset,
            'shops' => $shops->items(),
        ];
        return response()->json($data, 200);
    }

    public function getTankIndex(Request $request): JsonResponse
    {
        $limit = $request['limit'] ?? 10;
        $offset = $request['offset'] ?? 1;
        $tank = $this->tank->where('is_car',0)->latest()->paginate($limit, ['*'], 'page', $offset);
        $tanks = TanksResource::collection($tank);
        $data = [
            'total' => $tanks->total(),
            'limit' => $limit,
            'offset' => $offset,
            'tanks' => $tanks->items(),
        ];
        return response()->json($data, 200);
    }
    public function getAllTankIndex(Request $request): JsonResponse
    {
        $limit = $request['limit'] ?? 10;
        $offset = $request['offset'] ?? 1;
        $tank = $this->tank->latest()->paginate($limit, ['*'], 'page', $offset);
        $tanks = TanksResource::collection($tank);
        $data = [
            'total' => $tanks->total(),
            'limit' => $limit,
            'offset' => $offset,
            'tanks' => $tanks->items(),
        ];
        return response()->json($data, 200);
    }
    public function getCarIndex(Request $request): JsonResponse
    {
        $limit = $request['limit'] ?? 10;
        $offset = $request['offset'] ?? 1;
        $tank = $this->tank->where('is_car',1)->latest()->paginate($limit, ['*'], 'page', $offset);
        $tanks = TanksResource::collection($tank);
        $data = [
            'total' => $tanks->total(),
            'limit' => $limit,
            'offset' => $offset,
            'tanks' => $tanks->items(),
        ];
        return response()->json($data, 200);
    }



    public function getShopWithProducts(Request $request)
    {
        $shop_id = $request->input('shop_id');
        $shop = Shop::with('productNews')->find($shop_id);


        if (!$shop) {
            return response()->json(['message' => 'Shop not found'], 404);
        }

        $productNews = $shop->productNews()
            ->wherePivot('transaction_id', 1)
            ->get()
            ->map(function ($product) {
                return [
                    'id' => $product->id,
                    'title' => $product->name,
                    'image' => $product->image,
                    'quantity' => $product->pivot->absolute,
                ];
            });

        $data = [
            'id' => $shop->id,
            'title' => $shop->name,
            'productnews' => $productNews,
        ];

        return response()->json($data);
    }


    public function getTankWithProducts(Request $request)
    {
        $tank_id = $request->input('tank_id');
        $tank = Tank::with('productNews')->find($tank_id);


        if (!$tank) {
            return response()->json(['message' => 'Tank not found'], 404);
        }

        $data = [
            'id' => $tank->id,
            'name' => $tank->name,
            'productnews' => $tank->productNews->groupBy('pivot.product_new_id')->map(function ($products) {
                $latestProduct = $products->last();
                return [
                    'id' => $latestProduct->id,
                    'title' => $latestProduct->name,
                    'quantity' => $latestProduct->pivot->quantity,
                    'image' => $latestProduct->image,
                ];
            })->values(),
        ];

        return response()->json($data);
    }

    public function getTransactionIndex(Request $request): JsonResponse
    {
        $limit = $request['limit'] ?? 10;
        $offset = $request['offset'] ?? 1;


        $transactionNews = TransactionNew::with(['productNews', 'shops'])->orderBy('id', 'desc')->paginate($limit, ['*'], 'page', $offset);

        $transactionNewsCollections = TransactionNewsResource::collection($transactionNews);
        $data = [
            'total' => $transactionNews->total(),
            'limit' => $limit,
            'offset' => $offset,
            'transactionNews' => $transactionNewsCollections->items(),
        ];
        return response()->json($data, 200);
    }


    public function getTransferRecordIndex(Request $request): JsonResponse
    {
        $limit = $request['limit'] ?? 10;
        $offset = $request['offset'] ?? 1;


        $transferRecords = TransferRecord::with(['productNews'])->orderBy('id', 'desc')->paginate($limit, ['*'], 'page', $offset);

        $transferRecordsCollections = TransferRecordResource::collection($transferRecords);
        $data = [
            'total' => $transferRecords->total(),
            'limit' => $limit,
            'offset' => $offset,
            'transferRecords' => $transferRecordsCollections->items(),
        ];
        return response()->json($data, 200);
    }
    public function getProductNewIndex(Request $request): JsonResponse
    {
        $limit = $request['limit'] ?? 10;
        $offset = $request['offset'] ?? 1;
        $productNew = $this->productNew->latest()->paginate($limit, ['*'], 'page', $offset);
        $productNews = ProductNewsResource::collection($productNew);
        $data = [
            'total' => $productNews->total(),
            'limit' => $limit,
            'offset' => $offset,
            'productnews' => $productNews->items(),
        ];
        return response()->json($data, 200);
    }

    /**
     * @param Request $request
     * @return JsonResponse
     */
    public function orderList(Request $request): JsonResponse
    {
        $limit = $request['limit'] ?? 10;
        $offset = $request['offset'] ?? 1;

        $orders = $this->order->with('account')->latest()->paginate($limit, ['*'], 'page', $offset);
        $data = [
            'total' => $orders->total(),
            'limit' => $limit,
            'offset' => $offset,
            'orders' => $orders->items(),
        ];
        return response()->json($data, 200);
    }

    /**
     * @param Request $request
     * @return JsonResponse
     */
    public function invoiceGenerate(Request $request): JsonResponse
    {
        $validator = Validator::make($request->all(), [
            'order_id' => 'required',
        ]);
        if ($validator->fails()) {
            return response()->json(['errors' => Helpers::error_processor($validator)], 403);
        }
        $invoice = $this->order->with(['details', 'account'])->where(['id' => $request['order_id']])->first();
        return response()->json([
            'success' => true,
            'invoice' => $invoice,
        ], 200);
    }

    /**
     * @param Request $request
     * @return JsonResponse
     */
    public function placeOrder(Request $request): JsonResponse
    {
        if ($request['cart']) {
            if (count($request['cart']) < 1) {
                return response()->json(['message' => 'Cart empty'], 403);
            }
        }
        $user_id = $request->user_id;

        $coupon_code = 0;
        $product_price = 0;
        $order_details = [];
        $product_discount = 0;
        $product_tax = 0;
        $ext_discount = 0;
        $coupon_discount = $request->coupon_discount ?? 0;

        $order_id = 100000 + $this->order->all()->count() + 1;
        if ($this->order->find($order_id)) {
            $order_id = $this->order->orderBy('id', 'DESC')->first()->id + 1;
        }

        $order = $this->order;
        $order->id = $order_id;

        $order->user_id = $user_id;
        $order->coupon_code = $request['coupon_code'] ?? null;
        $order->coupon_discount_title = $request['coupon_title'] ?? null;
        $order->payment_id = $request->type;
        $order->transaction_reference = $request->transaction_reference ?? null;

        $order->created_at = now();
        $order->updated_at = now();

        foreach ($request['cart'] as $c) {
            if (is_array($c)) {
                $product = $this->product->find($c['id']);
                if ($product) {
                    $price = $c['price'];
                    $or_d = [
                        'product_id' => $c['id'],
                        'product_details' => $product,
                        'quantity' => $c['quantity'],
                        'price' => $product->selling_price,
                        //'tax' => Helpers::tax_calculate($product, $product->selling_price),
                        'tax_amount' => Helpers::tax_calculate($product, $product->selling_price),
                        'discount_on_product' => Helpers::discount_calculate($product, $product->selling_price),
                        'discount_type' => 'discount_on_product',
                        'created_at' => now(),
                        'updated_at' => now()
                    ];
                    $product_price += $price * $c['quantity'];
                    $product_discount += $c['discount'] * $c['quantity'];
                    $product_tax += $c['tax'] * $c['quantity'];
                    $order_details[] = $or_d;
                    if ($c['quantity'] > $product->quantity) {
                        return response()->json([
                            'message' => 'Please check product quantity'
                        ], 422);
                    }
                    $product->quantity = $product->quantity - $c['quantity'];
                    $product->order_count++;
                    $product->save();
                }
            }

        }
        $total_price = $product_price - $product_discount;

        if ($request->ext_discount_type == 'percent') {
            $order->extra_discount = ($product_price * $request->extra_discount) / 100;
        } else {
            $order->extra_discount = $request->extra_discount;
        }

        $total_tax_amount = $product_tax;
        try {
            $order->total_tax = $total_tax_amount;
            $order->order_amount = $total_price;

            $order->coupon_discount_amount = $coupon_discount;
            $order->collected_cash = $request->collected_cash ? $request->collected_cash : $total_price + $total_tax_amount - $ext_discount - $coupon_discount;
            $order->save();

            $customer = $this->customer->where('id', $user_id)->first();
            if ($user_id != 0 && $request->type == 0) {
                $grand_total = $total_price + $total_tax_amount - $ext_discount - $coupon_discount;

                if ($request->remaining_balance >= 0) {
                    $payable_account = $this->account->find(2);
                    $payable_transaction = $this->transection;
                    $payable_transaction->tran_type = 'Payable';
                    $payable_transaction->account_id = $payable_account->id;
                    $payable_transaction->amount = $grand_total;
                    $payable_transaction->description = 'POS order';
                    $payable_transaction->debit = 1;
                    $payable_transaction->credit = 0;
                    $payable_transaction->balance = $payable_account->balance - $grand_total;
                    $payable_transaction->date = date("Y/m/d");
                    $payable_transaction->customer_id = $customer->id;
                    $payable_transaction->order_id = $order_id;
                    $payable_transaction->save();

                    $payable_account->total_out = $payable_account->total_out + $grand_total;
                    $payable_account->balance = $payable_account->balance - $grand_total;
                    $payable_account->save();
                } else {
                    if ($customer->balance > 0) {
                        $payable_account = $this->account->find(2);
                        $payable_transaction = $this->transection;
                        $payable_transaction->tran_type = 'Payable';
                        $payable_transaction->account_id = $payable_account->id;
                        $payable_transaction->amount = $customer->balance;
                        $payable_transaction->description = 'POS order';
                        $payable_transaction->debit = 1;
                        $payable_transaction->credit = 0;
                        $payable_transaction->balance = $payable_account->balance - $customer->balance;
                        $payable_transaction->date = date("Y/m/d");
                        $payable_transaction->customer_id = $customer->id;
                        $payable_transaction->order_id = $order_id;
                        $payable_transaction->save();

                        $payable_account->total_out = $payable_account->total_out + $customer->balance;
                        $payable_account->balance = $payable_account->balance - $customer->balance;
                        $payable_account->save();

                        $receivable_account = $this->account->find(3);
                        $receivable_transaction = $this->transection;
                        $receivable_transaction->tran_type = 'Receivable';
                        $receivable_transaction->account_id = $receivable_account->id;
                        $receivable_transaction->amount = -$request->remaining_balance;
                        $receivable_transaction->description = 'POS order';
                        $receivable_transaction->debit = 0;
                        $receivable_transaction->credit = 1;
                        $receivable_transaction->balance = $receivable_account->balance - $request->remaining_balance;
                        $receivable_transaction->date = date("Y/m/d");
                        $receivable_transaction->customer_id = $customer->id;
                        $receivable_transaction->order_id = $order_id;
                        $receivable_transaction->save();

                        $receivable_account->total_in = $receivable_account->total_in - $request->remaining_balance;
                        $receivable_account->balance = $receivable_account->balance - $request->remaining_balance;
                        $receivable_account->save();
                    } else {

                        $receivable_account = $this->account->find(3);
                        $receivable_transaction = $this->transection;
                        $receivable_transaction->tran_type = 'Receivable';
                        $receivable_transaction->account_id = $receivable_account->id;
                        $receivable_transaction->amount = $grand_total;
                        $receivable_transaction->description = 'POS order';
                        $receivable_transaction->debit = 0;
                        $receivable_transaction->credit = 1;
                        $receivable_transaction->balance = $receivable_account->balance + $grand_total;
                        $receivable_transaction->date = date("Y/m/d");
                        $receivable_transaction->customer_id = $customer->id;
                        $receivable_transaction->order_id = $order_id;
                        $receivable_transaction->save();

                        $receivable_account->total_in = $receivable_account->total_in + $grand_total;
                        $receivable_account->balance = $receivable_account->balance + $grand_total;
                        $receivable_account->save();
                    }
                }

                $customer->balance = $request->remaining_balance;

                $customer->save();
            }

            if ($request->type != 0) {
                $account = $this->account->find($request->type);
                $transection = $this->transection;
                $transection->tran_type = 'Income';
                $transection->account_id = $request->type;
                $transection->amount = $total_price + $total_tax_amount - $ext_discount - $coupon_discount;
                $transection->description = 'POS order';
                $transection->debit = 0;
                $transection->credit = 1;
                $transection->balance = $account->balance + $total_price + $total_tax_amount - $ext_discount - $coupon_discount;
                $transection->date = date("Y/m/d");
                $transection->customer_id = $customer->id;
                $transection->order_id = $order_id;
                $transection->save();

                $account->balance = $account->balance + $total_price + $total_tax_amount - $ext_discount - $coupon_discount;
                $account->total_in = $account->total_in + $total_price + $total_tax_amount - $ext_discount - $coupon_discount;
                $account->save();
            }
            foreach ($order_details as $key => $item) {
                $order_details[$key]['order_id'] = $order->id;
            }
            $this->order_detail->insert($order_details);
            return response()->json([
                'message' => 'Order placed successfully',
                'order_id' => $order_id
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Failed to placed order'
            ], 400);
        }
    }

    /**
     * @param $c
     * @param $price
     * @return float|int
     */
    public function extra_dis_calculate($c, $price): float|int
    {
        if ($c['ext_discount_type'] == 'percent') {
            $price_discount = ($price / 100) * $c['ext_discount'];
        } else {
            $price_discount = $c['ext_discount'];
        }
        return $price_discount;
    }

    /**
     * @param Request $request
     * @return JsonResponse
     */
    public function storeProduct(Request $request): JsonResponse
    {
        $validator = Validator::make($request->all(), [
            'name' => 'required|unique:products',
            'product_code' => 'required|unique:products',
            'category_id' => 'required',
            'unit_type' => 'required',
            'unit_value' => 'required|numeric|min:0',
            'quantity' => 'required|numeric|min:1',
            'purchase_price' => 'required|numeric|min:1',
            'selling_price' => 'required|numeric|min:1',
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => Helpers::error_processor($validator)], 403);
        }

        if ($request['discount_type'] == 'percent') {
            $dis = ($request['selling_price'] / 100) * $request['discount'];
        } else {
            $dis = $request['discount'];
        }
        if ($request['selling_price'] <= $dis) {
            return response()->json([
                'success' => false,
                'message' => translate('Discount can not be more than Selling price'),
            ], 403);
        }

        $products = $this->product;
        $products->name = $request->name;
        $products->product_code = $request->product_code;
        $category = [];

        if ($request->category_id != null) {
            $category[] = [
                'id' => $request->category_id,
                'position' => 1,
            ];
        }
        if ($request->sub_category_id != null) {
            $category[] = [
                'id' => $request->sub_category_id,
                'position' => 2,
            ];
        }

        $products->category_ids = json_encode($category);
        $products->purchase_price = $request->purchase_price;
        $products->selling_price = $request->selling_price;
        $products->unit_type = $request->unit_type;
        $products->unit_value = $request->unit_value;
        $products->brand = $request->brand;
        $products->discount_type = $request->discount_type;
        $products->discount = $request->discount ?? 0;
        $products->tax = $request->tax ?? 0;
        $products->order_count = 0;
        $products->quantity = $request->quantity;
        $products->image = Helpers::upload('product/', 'png', $request->file('image'));
        $products->supplier_id = $request->supplier_id;
        $products->save();
        return response()->json([
            'success' => true,
            'message' => translate('Product saved successfully'),
        ], 200);
    }

    public function storeProductNew(Request $request): JsonResponse
    {
        $validator = Validator::make($request->all(), [
            'name' => 'required|unique:product_news',
            'quantity' => 'required|numeric|min:0',
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => Helpers::error_processor($validator)], 403);
        }



        $productNews = $this->productNew;
        $productNews->name = $request->name;

        $productNews->quantity = $request->quantity;
        $productNews->image = Helpers::upload('product/', 'png', $request->file('image'));
        $productNews->save();
        return response()->json([
            'success' => true,
            'message' => translate('Product saved successfully'),
        ], 200);
    }

    public function storeShop(Request $request): JsonResponse
    {
        $validator = Validator::make($request->all(), [
            'name' => 'required|unique:shops',
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => Helpers::error_processor($validator)], 403);
        }



        $shops = $this->shop;
        $shops->name = $request->name;
        $shops->phonenumber = $request->phonenumber ?? '';
        $shops->description = $request->description ?? '';
        if ($request->hasFile('image')) {
            $shops->image = Helpers::upload('product/', 'png', $request->file('image'));
        }

        $shops->save();
        return response()->json([
            'success' => true,
            'message' => translate('Shop saved successfully'),
        ], 200);
    }


    public function storeTank(Request $request): JsonResponse
    {
        $validator = Validator::make($request->all(), [
            // 'name' => 'required|unique:tanks',
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => Helpers::error_processor($validator)], 403);
        }



        $tanks = $this->tank;
        $tanks->name = $request->name;
        $tanks->total_quantity = $request->total_quantity ?? 0;
        $tanks->description = $request->description ?? '';
        $tanks->is_car = false;


        $tanks->image = Helpers::upload('product/', 'png', $request->file('image'));
        $tanks->save();
        return response()->json([
            'success' => true,
            'message' => translate('Tank saved successfully'),
        ], 200);
    }

    public function storeCar(Request $request): JsonResponse
    {
        $validator = Validator::make($request->all(), [
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => Helpers::error_processor($validator)], 403);
        }



        $tanks = $this->tank;
        $tanks->name = $request->name;

        $tanks->car_series = $request->car_series??'';
        $tanks->car_type = $request->car_type?? '';
        $tanks->driver_name = $request->driver_name ?? '';
        $tanks->driver_phone_number = $request->driver_phone_number ?? '';

        $tanks->total_quantity = $request->total_quantity ?? 0;
        $tanks->description = $request->description ?? '';
        $tanks->is_car = true;


        $tanks->image = Helpers::upload('product/', 'png', $request->file('image'));
        $tanks->save();
        return response()->json([
            'success' => true,
            'message' => translate('Car saved successfully'),
        ], 200);
    }

    /**
     * @param Request $request
     * @return JsonResponse
     */
    public function productUpdate(Request $request): JsonResponse
    {
        $product = $this->product->find($request->id);
        $request->validate([
            'id' => 'required',
            'name' => 'required|unique:products,name,' . $product->id,
            'product_code' => 'required|unique:products,product_code,' . $product->id,
            'category_id' => 'required',
            'unit_type' => 'required',
            'quantity' => 'required|numeric|min:1',
            'purchase_price' => 'required|numeric|min:1',
            'selling_price' => 'required|numeric|min:1',
        ], [
            'name.required' => translate('Product name is required'),
            'category_id.required' => translate('Category  is required'),
        ]);

        if ($request['discount_type'] == 'percent') {
            $dis = ($request['selling_price'] / 100) * $request['discount'];
        } else {
            $dis = $request['discount'];
        }

        if ($request['selling_price'] <= $dis) {
            return response()->json([
                'success' => false,
                'message' => translate('Discount can not be more than Selling price'),
            ], 403);
        }
        $product->name = $request->name;
        $product->product_code = $request->product_code;

        $category = [];
        if ($request->category_id != null) {
            $category[] = [
                'id' => $request->category_id,
                'position' => 1,
            ];
        }
        if ($request->sub_category_id != null) {
            $category[] = [
                'id' => $request->sub_category_id,
                'position' => 2,
            ];
        }

        $product->category_ids = json_encode($category);

        $product->purchase_price = $request->purchase_price;
        $product->selling_price = $request->selling_price;
        $product->unit_type = $request->unit_type;
        $product->unit_value = $request->unit_value;
        $product->brand = $request->brand;
        $product->discount_type = $request->discount_type;
        $product->discount = $request->discount ?? 0;
        $product->tax = $request->tax ?? 0;
        $product->quantity = $request->quantity;
        $product->image = $request->has('image') ? Helpers::update('product/', $product->image, 'png', $request->file('image')) : $product->image;
        $product->supplier_id = $request->supplier_id;
        $product->save();
        return response()->json([
            'success' => true,
            'message' => translate('Product updated successfully'),
        ], 200);
    }
    public function productNewUpdate(Request $request): JsonResponse
    {
        $productNew = $this->productNew->find($request->id);
        $request->validate([
            'id' => 'required',
            'name' => 'required|unique:product_news,name,' . $productNew->id,
            'quantity' => 'required|numeric|min:0',
        ], [
            'name.required' => translate('Product name is required'),
        ]);


        $productNew->name = $request->name;


        $productNew->quantity = $request->quantity;
        $productNew->image = $request->has('image') ? Helpers::update('product/', $productNew->image, 'png', $request->file('image')) : $productNew->image;
        $productNew->save();
        return response()->json([
            'success' => true,
            'message' => translate('Product updated successfully'),
        ], 200);
    }

    public function shopUpdate(Request $request): JsonResponse
    {
        $shop = $this->shop->find($request->id);
        $request->validate([
            'id' => 'required',
            'name' => 'required|unique:shops,name,' . $shop->id,
        ], [
            'name.required' => translate('Shop name is required'),
        ]);


        $shop->name = $request->name;

        $shop->phonenumber = $request->phonenumber??'';
        $shop->description = $request->description??'';


        $shop->image = $request->has('image') ? Helpers::update('product/', $shop->image, 'png', $request->file('image')) : $shop->image;
        $shop->save();
        return response()->json([
            'success' => true,
            'message' => translate('Shop updated successfully'),
        ], 200);
    }


    public function tankUpdate(Request $request): JsonResponse
    {
        $tank = $this->tank->find($request->id);
        $request->validate([
            'id' => 'required',
            // 'name' => 'required|unique:shops,name,' . $shop->id,
        ], [
            // 'name.required' => translate('Shop name is required'),
        ]);


        $tank->name = $request->name;
        $tank->total_quantity = $request->total_quantity??0;
        $tank->description = $request->description??'';
        $tank->is_car = false;
        $tank->image = $request->has('image') ? Helpers::update('product/', $tank->image, 'png', $request->file('image')) : $tank->image;
        $tank->save();
        return response()->json([
            'success' => true,
            'message' => translate('Tank updated successfully'),
        ], 200);
    }

    public function carUpdate(Request $request): JsonResponse
    {
        $tank = $this->tank->find($request->id);
        $request->validate([
            'id' => 'required',
            // 'name' => 'required|unique:shops,name,' . $shop->id,
        ], [
            // 'name.required' => translate('Shop name is required'),
        ]);


        $tank->name = $request->name;

        $tank->car_series = $request->car_series??'';
        $tank->car_type = $request->car_type??'';
        $tank->driver_name = $request->driver_name??'';
        $tank->driver_phone_number = $request->driver_phone_number??'';






        $tank->total_quantity = $request->total_quantity??0;
        $tank->description = $request->description??'';
        $tank->is_car = true;
        $tank->image = $request->has('image') ? Helpers::update('product/', $tank->image, 'png', $request->file('image')) : $tank->image;
        $tank->save();
        return response()->json([
            'success' => true,
            'message' => translate('Tank updated successfully'),
        ], 200);
    }

    /**
     * @param Request $request
     * @return JsonResponse
     */
    public function getSearch(Request $request): JsonResponse
    {
        $limit = $request['limit'] ?? 10;
        $offset = $request['offset'] ?? 1;
        $search = $request->name;
        $stock_limit = $this->business_setting->where('key', 'stock_limit')->first()->value;

        if (!empty($search)) {
            $result = $this->product->where('product_code', 'like', '%' . $search . '%')
                ->orWhere('name', 'like', '%' . $search . '%')->latest()->paginate($limit, ['*'], 'page', $offset);
            $products = ProductsResource::collection($result);
            $data = [
                'total' => $products->total(),
                'limit' => $limit,
                'offset' => $offset,
                'products' => $products->items(),
            ];
        } else {
            $data = [
                'total' => 0,
                'limit' => $limit,
                'offset' => $offset,
                'products' => [],
            ];
        }
        return response()->json($data, 200);
    }
    public function getSearchNew(Request $request): JsonResponse
    {
        $limit = $request['limit'] ?? 10;
        $offset = $request['offset'] ?? 1;
        $search = $request->name;
        $stock_limit = $this->business_setting->where('key', 'stock_limit')->first()->value;

        if (!empty($search)) {
            $result = $this->productNew->latest()->paginate($limit, ['*'], 'page', $offset);
            $productNews = ProductNewsResource::collection($result);
            $data = [
                'total' => $productNews->total(),
                'limit' => $limit,
                'offset' => $offset,
                'productnews' => $productNews->items(),
            ];
        } else {
            $data = [
                'total' => 0,
                'limit' => $limit,
                'offset' => $offset,
                'productnews' => [],
            ];
        }
        return response()->json($data, 200);
    }
    public function getSearchShop(Request $request): JsonResponse
    {
        $limit = $request['limit'] ?? 10;
        $offset = $request['offset'] ?? 1;
        $search = $request->name;
        $stock_limit = $this->business_setting->where('key', 'stock_limit')->first()->value;

        if (!empty($search)) {
            $result = $this->productNew->latest()->paginate($limit, ['*'], 'page', $offset);
            $shops = ShopsResource::collection($result);
            $data = [
                'total' => $shops->total(),
                'limit' => $limit,
                'offset' => $offset,
                'shops' => $shops->items(),
            ];
        } else {
            $data = [
                'total' => 0,
                'limit' => $limit,
                'offset' => $offset,
                'shops' => [],
            ];
        }
        return response()->json($data, 200);
    }

    public function getSearchTank(Request $request): JsonResponse
    {
        $limit = $request['limit'] ?? 10;
        $offset = $request['offset'] ?? 1;
        $search = $request->name;
        $stock_limit = $this->business_setting->where('key', 'stock_limit')->first()->value;

        if (!empty($search)) {
            $result = $this->tank->latest()->paginate($limit, ['*'], 'page', $offset);
            $tanks = TanksResource::collection($result);
            $data = [
                'total' => $tanks->total(),
                'limit' => $limit,
                'offset' => $offset,
                'tanks' => $tanks->items(),
            ];
        } else {
            $data = [
                'total' => 0,
                'limit' => $limit,
                'offset' => $offset,
                'tanks' => [],
            ];
        }
        return response()->json($data, 200);
    }

    /**
     * @param Request $request
     * @return JsonResponse
     * @throws \Throwable
     */
    public function delete(Request $request): JsonResponse
    {
        try {
            $product = $this->product->findOrFail($request->id);
            $image_path = public_path('/storage/app/public/product/') . $product->image;
            if (!is_null($image_path)) {
                $product->delete();
                if (file_exists($image_path)) {
                    unlink($image_path);
                }
            }
            return response()->json([
                'success' => true,
                'message' => translate('Product deleted successfully'),
            ], 200);
        } catch (\Throwable $th) {
            throw $th;
            return redirect()->back()->with('success', 'Product not deleted!');
        }
    }

    public function deleteNew(Request $request): JsonResponse
    {
        try {
            $productNew = $this->productNew->findOrFail($request->id);
            $image_path = public_path('/storage/app/public/product/') . $productNew->image;
            if (!is_null($image_path)) {
                $productNew->delete();
                if (file_exists($image_path)) {
                    unlink($image_path);
                }
            }
            return response()->json([
                'success' => true,
                'message' => translate('Product deleted successfully'),
            ], 200);
        } catch (\Throwable $th) {
            throw $th;
            return redirect()->back()->with('success', 'Product not deleted!');
        }
    }

    public function deleteShop(Request $request): JsonResponse
    {
        try {
            $shop = $this->shop->findOrFail($request->id);
            $image_path = public_path('/storage/app/public/product/') . $shop->image;
            if (!is_null($image_path)) {
                $shop->delete();
                if (file_exists($image_path)) {
                    unlink($image_path);
                }
            }
            return response()->json([
                'success' => true,
                'message' => translate('Shop deleted successfully'),
            ], 200);
        } catch (\Throwable $th) {
            throw $th;
            return redirect()->back()->with('success', 'Shop not deleted!');
        }
    }

    public function deleteTank(Request $request): JsonResponse
    {
        try {
            $tank = $this->tank->findOrFail($request->id);
            $image_path = public_path('/storage/app/public/product/') . $tank->image;
            if (!is_null($image_path)) {
                $tank->delete();
                if (file_exists($image_path)) {
                    unlink($image_path);
                }
            }
            return response()->json([
                'success' => true,
                'message' => translate('Tank deleted successfully'),
            ], 200);
        } catch (\Throwable $th) {
            throw $th;
            return redirect()->back()->with('success', 'Tank not deleted!');
        }
    }

    public function deleteCar(Request $request): JsonResponse
    {
        try {
            $tank = $this->tank->findOrFail($request->id);
            $image_path = public_path('/storage/app/public/product/') . $tank->image;
            if (!is_null($image_path)) {
                $tank->delete();
                if (file_exists($image_path)) {
                    unlink($image_path);
                }
            }
            return response()->json([
                'success' => true,
                'message' => translate('Car deleted successfully'),
            ], 200);
        } catch (\Throwable $th) {
            throw $th;
            return redirect()->back()->with('success', 'Tank not deleted!');
        }
    }

    /**
     * @param Request $request
     * @return JsonResponse
     */
    public function orderGetSearch(Request $request): JsonResponse
    {
        $limit = $request['limit'] ?? 10;
        $offset = $request['offset'] ?? 1;
        $search = $request->name;
        if (!empty($search)) {
            $result = $this->order->where('id', 'like', '%' . $search . '%')->latest()->paginate($limit, ['*'], 'page', $offset);
            $data = [
                'total' => $result->total(),
                'limit' => $limit,
                'orders' => $result->items(),
            ];
        } else {
            $data = [
                'total' => 0,
                'limit' => $limit,
                'offset' => $offset,
                'orders' => [],
            ];
        }
        return response()->json($data, 200);
    }

    /**
     * @param Request $request
     * @return JsonResponse
     */
    public function customerOrders(Request $request): JsonResponse
    {
        $limit = $request['limit'] ?? 10;
        $offset = $request['offset'] ?? 1;

        $orders = $this->order->with('account')->where('user_id', $request->customer_id)->latest()->paginate($limit, ['*'], 'page', $offset);
        $data = [
            'total' => $orders->total(),
            'limit' => $limit,
            'offset' => $offset,
            'orders' => $orders->items(),
        ];
        return response()->json($data, 200);
    }
}
