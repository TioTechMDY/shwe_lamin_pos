@extends('layouts.admin.app')

@section('title', \App\CPU\translate('update_tank'))

@section('content')
<div class="content container-fluid">
    <div class="">
        <div class="row align-items-center mb-3">
            <div class="col-sm mb-2 mb-sm-0">
                <h1 class="page-header-title d-flex align-items-center g-2px text-capitalize">
                    <i class="tio-edit"></i>
                    <span>{{\App\CPU\translate('update_tank')}}</span>
                </h1>
            </div>
        </div>
    </div>
    <div class="row gx-2 gx-lg-3">
        <div class="col-sm-12 col-lg-12 mb-3 mb-lg-2">
            <div class="card">
                <div class="card-body">
                    <form action="{{route('admin.tank.update', [$tank['id']])}}" method="post" id="product_form"
                        enctype="multipart/form-data">
                        @csrf
                        <div class="row pl-2">
                            <div class="col-12 col-sm-6">
                                <div class="form-group">
                                    <label class="input-label"
                                        for="exampleFormControlInput1">{{\App\CPU\translate('name')}}
                                        <span class="input-label-secondary">*</span>
                                    </label>
                                    <input type="text" name="name" class="form-control" value="{{ $tank['name'] }}"
                                        placeholder="{{\App\CPU\translate('product_name')}}" required>
                                </div>
                            </div>
                            <div class="col-12 col-sm-6">
                                <div class="form-group">
                                    <label class="input-label"
                                        for="exampleFormControlInput1">{{\App\CPU\translate('description')}}
                                    </label>
                                    <input type="text" name="description" class="form-control"
                                        value="{{ $tank['description'] }}"
                                        placeholder="{{\App\CPU\translate('description')}}" >
                                </div>
                            </div>

                        </div>
                        <div class="row pl-2">
                            <div class="col-12 col-sm-6">
                                <div class="form-group">
                                    <label class="input-label"
                                        for="exampleFormControlInput1">{{\App\CPU\translate('quantity')}}
                                        <span class="input-label-secondary">*</span>
                                    </label>
                                    <input type="number" min="0" name="quantity" class="form-control"
                                        value="{{ $tank['quantity'] }}" placeholder="{{\App\CPU\translate('quantity')}}"
                                        required>
                                </div>
                            </div>
                            <div class="col-12 col-sm-6">
                                <div class="form-group">
                                    <label class="input-label"
                                        for="exampleFormControlInput1">{{\App\CPU\translate('maximun_quantity')}}
                                        <span class="input-label-secondary">*</span>
                                    </label>
                                    <input type="number" min="0" name="maximun" class="form-control"
                                        value="{{ $tank['maximun'] }}" placeholder="{{\App\CPU\translate('maximun_quantity')}}"
                                        required>
                                </div>
                            </div>
                        </div>
                        <div class="row pl-2">
                            
                            <div class="col-12 col-sm-6">
                                <div class="form-group">
                                    <label class="input-label"
                                        for="exampleFormControlInput1">{{\App\CPU\translate('select_product')}}</label>
                                    <select class="form-control js-select2-custom" name="product_id" id="product_id">
                                        <option value="">---{{\App\CPU\translate('select')}}---</option>
                                        @foreach ($products as $product)
                                            <option value="{{$product['id']}}" {{ $tank->product_id == $product['id'] ? 'selected' : '' }}>{{$product['name']}}
                                            </option>
                                        @endforeach

                                    </select>
                                </div>
                            </div>
                        </div>

                </div>


                <div class="row pl-2">
                    <div class="col-12">
                        <label>{{\App\CPU\translate('image')}}</label>
                        <div class="custom-file">
                            <input type="file" name="image" id="customFileEg1" class="custom-file-input"
                                accept=".jpg, .png, .jpeg, .gif, .bmp, .tif, .tiff|image/*">
                            <label class="custom-file-label"
                                for="customFileEg1">{{\App\CPU\translate('choose_file')}}</label>
                        </div>
                        <div class="form-group my-4">
                            <div class="text-center">
                                <img class="img-one-pu" id="viewer" src="{{$tank['image_fullpath']}}"
                                    alt="{{ \App\CPU\translate('image')}}" />
                            </div>
                        </div>
                    </div>
                </div>
                <button type="submit" class="btn btn-primary">{{\App\CPU\translate('update')}}</button>
                </form>
            </div>
        </div>
    </div>
</div>
</div>
@endsection

@push('script_2')
    <script>
        "use strict";


    </script>

    <script src={{asset("public/assets/admin/js/global.js")}}></script>
@endpush