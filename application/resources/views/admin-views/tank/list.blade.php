@extends('layouts.admin.app')

@section('title', \App\CPU\translate('tank_list'))

@push('css_or_js')
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <style>
        .supplier-color {
            color: #677788;
        }
    </style>
@endpush

@section('content')
<div class="content container-fluid">
    <div class="">
        <div class="d-flex align-items-center g-2px align-items-center mb-3">
            <h1 class="page-header-title d-flex align-items-center g-2px text-capitalize">
                <i class="tio-files"></i> <span>{{\App\CPU\translate('tank_list')}}
                    <span class="badge badge-soft-dark ml-2">{{$tanks->total()}}</span></span>
            </h1>
            <div class="ml-auto">
                <a href="{{route('admin.tank.add')}}" class="btn btn-primary"><i class="tio-add-circle"></i>
                    {{\App\CPU\translate('add')}} {{\App\CPU\translate('new')}} {{\App\CPU\translate('tank')}}
                </a>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-sm-12 col-lg-12 mb-3 mb-lg-2">
            <div class="card">
                <div class="table-responsive datatable-custom">
                    <table
                        class="table table-borderless table-thead-bordered table-nowrap table-align-middle card-table">
                        <thead class="thead-light">
                            <tr>
                                <th>{{\App\CPU\translate('#')}}</th>
                                <th>{{\App\CPU\translate('name')}}</th>
                                <th>{{\App\CPU\translate('image')}}</th>
                                <th>{{\App\CPU\translate('quantity')}}</th>
                                <th>{{\App\CPU\translate('maximun_quantity')}}</th>
                                <th>{{ \App\CPU\translate('product') }}</th>
                                <th>{{\App\CPU\translate('action')}}</th>
                            </tr>
                        </thead>
                        <tbody id="set-rows">
                            @foreach($tanks as $key => $tank)
                                <tr>
                                    <td>{{$tanks->firstitem() + $key}}</td>
                                    <td>
                                        <span class="d-block font-size-sm text-body">
                                            {{substr($tank['name'], 0, 20)}}{{strlen($tank['name']) > 20 ? '...' : ''}}
                                        </span>
                                    </td>
                                    <td>
                                        <img class="img-one-plst" src="{{$tank['image_fullpath']}}">
                                    </td>
                                    <td>
                                        {{ $tank['quantity'] }}
                                    </td>
                                    <td>
                                        {{ $tank['maximun'] }}
                                    </td>
                                    @if ($tank->product)
                                        <td> {{ $tank->product->name}}</td>
                                    @else
                                        <td> Unknown</td>
                                    @endif
                                    <td>
                                        <div class="d-flex gap-2">
                                            <div class="d-inline">
                                                <a class="btn btn-white mr-1"
                                                    href="{{route('admin.tank.edit', [$tank['id']])}}"> <span
                                                        class="tio-edit"></span></a>
                                            </div>
                                            <div class="d-inline">
                                                <a class="btn btn-white mr-1 form-alert" href="javascript:"
                                                    data-id="product-{{$tank['id']}}"
                                                    data-message="{{ \App\CPU\translate('Want to delete this tank') }}?"><span
                                                        class="tio-delete"></span></a>
                                                <form action="{{route('admin.tank.delete', [$tank['id']])}}" method="post"
                                                    id="product-{{$tank['id']}}">
                                                    @csrf @method('delete')
                                                </form>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                            @endforeach
                        </tbody>
                    </table>

                    @if(count($tanks) == 0)
                        <div class="text-center p-4">
                            <img class="mb-3 img-two-plst"
                                src="{{asset('assets/admin')}}/svg/illustrations/sorry.svg"
                                alt="{{ \App\CPU\translate('Image Description')}}">
                            <p class="mb-0">{{ \App\CPU\translate('No_data_to_show')}}</p>
                        </div>
                    @endif
                </div>
            </div>
        </div>
    </div>
</div>

@endsection

@push('script_2')
    <script src={{asset("assets/admin/js/global.js")}}></script>

    <script>
        // "use strict";

        // $('#qtyOrderSortSelect').on('change', function() {
        //     var selectedValue = $(this).val();
        //     var redirectUrl = '{{ url('/') }}/admin/product/list/?sort_orderQty=' + selectedValue;
        //     window.location.href = redirectUrl;
        // });

        // $('.update-quantity-btn').on('click', function() {
        //     var productId = $(this).data('product-id');
        //     update_quantity_plst(productId);
        // });

    </script>
@endpush