<?php

namespace App\Http\Controllers\Admin;

use App\Models\Product;
use App\CPU\Helpers;
use App\Models\Tank;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Brian2694\Toastr\Facades\Toastr;
use Box\Spout\Common\Exception\InvalidArgumentException;
use Box\Spout\Common\Exception\IOException;
use Box\Spout\Common\Exception\UnsupportedTypeException;
use Box\Spout\Writer\Exception\WriterNotOpenedException;
use Carbon\Carbon;
use Illuminate\Contracts\Foundation\Application;
use Illuminate\Contracts\View\Factory;
use Illuminate\Contracts\View\View;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\RedirectResponse;
use PDF;
use App\Models\Unit;
use App\Models\Brand;
use App\Models\Category;
use App\Models\Supplier;
use Illuminate\Support\Str;
use Symfony\Component\HttpFoundation\StreamedResponse;
use function App\CPU\translate;
use Illuminate\Support\Facades\DB;
use Rap2hpoutre\FastExcel\FastExcel;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Validator;
use Symfony\Component\Console\Input\Input;

class TankController extends Controller
{
    public function __construct(private Tank $tank, private Product $product)
    {
    }

    public function index()
    {
        $products = $this->product->get();


        return view('admin-views.tank.add', compact('products'));
    }

    public function list(Request $request)
    {
        //        dd($request->all());
        $queryParam = [];
        $search = $request['search'];
        $sortOrderQty = $request['sort_orderQty'];
        if ($request->has('search')) {
            $key = explode(' ', $request['search']);
            $query = $this->tank->where(function ($q) use ($key) {
                foreach ($key as $value) {
                    $q->orWhere('name', 'like', "%{$value}%")
                        ->orWhere('product_code', 'like', "%{$value}%");
                }
            });
            $queryParam = ['search' => $request['search']];
        } else {
            $query = $this->tank
                ->when($request->sort_orderQty == 'quantity_asc', function ($q) use ($request) {
                    return $q->orderBy('quantity', 'asc');
                })
                ->when($request->sort_orderQty == 'quantity_desc', function ($q) use ($request) {
                    return $q->orderBy('quantity', 'desc');
                })
                ->when($request->sort_orderQty == 'order_asc', function ($q) use ($request) {
                    return $q->orderBy('order_count', 'asc');
                })
                ->when($request->sort_orderQty == 'order_desc', function ($q) use ($request) {
                    return $q->orderBy('order_count', 'desc');
                })
                ->when($request->sort_orderQty == 'default', function ($q) use ($request) {
                    return $q->orderBy('id');
                });
        }
        $tanks = $query->latest()->paginate(Helpers::pagination_limit())->appends(['search' => $search, 'sort_orderQty' => $request->sort_orderQty]);
        return view('admin-views.tank.list', compact('tanks'));
    }

    public function create()
    {
        return view('tanks.create');
    }

    public function store(Request $request)
    {
        $request->validate(
            [
                'name' => 'required|unique:tanks',
                'product_id' => 'required',
                'quantity' => 'required|numeric|min:0',
                'image' => 'image|mimes:jpeg,png,jpg,gif|max:2048'
            ],

            [
                'name.required' => translate('Tank name is required'),
                'product_id.required' => translate('Product  is required'),
            ]
        );



        $tanks = $this->tank;
        $tanks->name = $request->name;
        $tanks->description = $request->description;

        $tanks->image = Helpers::upload('tank/', 'png', $request->file('image'));
        $tanks->quantity = $request->quantity;



        $tanks->product_id = $request->product_id;
        $tanks->save();




        Toastr::success(translate('Tank Added Successfully'));
        return redirect()->route('admin.tank.list');
    }

    public function delete(Request $request): RedirectResponse
    {
        $tank = $this->tank->find($request->id);
        if (Storage::disk('public')->exists('tank/' . $tank->image)) {
            Storage::disk('public')->delete('tank/' . $tank->image);
        }

        $tank->delete();

        Toastr::success(translate('Tank removed'));
        return back();
    }

    public function show(Tank $tank)
    {
        return view('tanks.show', compact('tank'));
    }

    public function edit($id): Factory|View|Application
    {
        $tank = $this->tank->find($id);
        $products = $this->product->get();

        return view('admin-views.tank.edit', compact('tank', 'products'));
    }

    public function update(Request $request, $id)
    {
        $tank = $this->tank->find($id);

        $request->validate(
            [
                'name' => 'required|unique:tanks,name,'.$tank->id,
                'product_id' => 'required',
                'quantity' => 'required|numeric|min:0',
                'image' => 'image|mimes:jpeg,png,jpg,gif|max:2048'
            ],

            [
                'name.required' => translate('Tank name is required'),
                'product_id.required' => translate('Product  is required'),
            ]
        );


        $tank->name = $request->name;
        $tank->description = $request->description;

        $tank->quantity = $request->quantity;

        $tank->image = $request->has('image') ? Helpers::update('tank/', $tank->image, 'png', $request->file('image')) : $tank->image;
        $tank->product_id = $request->product_id;
        $tank->save();

        Toastr::success('Tank Updated Successfully');
        return redirect()->route('admin.tank.list');
    }

    public function destroy(Tank $tank)
    {
        $tank->delete();

        Toastr::success('Tank Removed Successfully');
        return redirect()->route('tanks.index');
    }
}
