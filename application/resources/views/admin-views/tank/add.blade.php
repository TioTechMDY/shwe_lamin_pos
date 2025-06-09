@extends('layouts.admin.app')

@section('title', \App\CPU\translate('add_new_tank'))

@section('content')
<div class="content container-fluid">
    <div class="">
        <div class="row align-items-center mb-3">
            <div class="col-sm mb-2 mb-sm-0">
                <h1 class="page-header-title d-flex align-items-center g-2px text-capitalize">
                    <i class="tio-add-circle-outlined"></i>
                    <span>{{\App\CPU\translate('add_new_tank')}}</span>
                </h1>
            </div>
        </div>
    </div>
    <div class="row gx-2 gx-lg-3">
        <div class="col-sm-12 col-lg-12 mb-3 mb-lg-2">
            <div class="card">
                <div class="card-body">
                    <form action="{{route('admin.tank.store')}}" method="post" id="product_form"
                        enctype="multipart/form-data">
                        @csrf
                        <div class="row pl-2">
                            <div class="col-12 col-sm-6">
                                <div class="form-group">
                                    <label class="input-label"
                                        for="exampleFormControlInput1">{{\App\CPU\translate('name')}}
                                        <span class="input-label-secondary">*</span>
                                    </label>
                                    <input type="text" name="name" class="form-control" value="{{ old('product_name') }}"
                                        placeholder="{{\App\CPU\translate('name')}}" required>
                                </div>
                            </div>
                            <div class="col-12 col-sm-6">
                                <div class="form-group">
                                    <label class="input-label"
                                        for="exampleFormControlInput1">{{\App\CPU\translate('description')}}
                                    </label>
                                    <input type="text" name="description" class="form-control" value="{{ old('description') }}"
                                        placeholder="{{\App\CPU\translate('description')}}" required>
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
                                        value="{{ old('quantity') }}" placeholder="{{\App\CPU\translate('quantity')}}"
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
                                        value="{{ old('maximun') }}" placeholder="{{\App\CPU\translate('maximun_quantity')}}"
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
                                                <option
                                                    value="{{$product['id']}}" {{ old('product_id')==$product['id']?'selected':''}}>
                                                    {{$product['name']}}
                                                </option>
                                            @endforeach

                                    </select>
                                </div>
                            </div>
                        </div>

                        <div class="row pl-2">
                            <div class="col-12 col-sm-12">
                                <label>{{\App\CPU\translate('image')}}</label>
                                <div class="custom-file">
                                    <input type="file" name="image" id="customFileEg1" class="custom-file-input"
                                        accept=".jpg, .png, .jpeg, .gif, .bmp, .tif, .tiff|image/*">
                                    <label class="custom-file-label"
                                        for="customFileEg1">{{\App\CPU\translate('choose')}}
                                        {{\App\CPU\translate('file')}}</label>
                                </div>
                                <div class="form-group my-4">
                                    <div class="text-center">
                                        <img class="style-two-pro" id="viewer"
                                            src="{{asset('assets/admin/img/400x400/img2.jpg')}}"
                                            alt="{{\App\CPU\translate('image')}}" />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <button type="submit" class="btn btn-primary">{{\App\CPU\translate('submit')}}</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection

@push('script_2')
    <script src={{asset("assets/admin/js/global.js")}}></script>

    <script>
        "use strict";

        $(document).ready(function () {

            $('#generateCodeLink').on('click', function (e) {
                e.preventDefault();
                document.getElementById('generate_number').value = getRndInteger();
            });

            $('select[name="category_id"]').on('change', function () {
                getRequest('{{url('/')}}/admin/product/get-categories?parent_id=' + $(this).val(), 'sub-categories');
            });

            $('select[name="sub_category_id"]').on('change', function () {
                getRequest('{{url('/')}}/admin/product/get-categories?parent_id=' + $(this).val(), 'sub-sub-categories');
            });

            $('select[name="discount_type"]').on('change', function () {
                discount_option(this);
            });
        });
    </script>
@endpush