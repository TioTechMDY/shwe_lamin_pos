@extends('layouts.blank')

@section('content')
    <div class="container">
        <div class="row mt-5">
            <div class="col-2"></div>
            <div class="col-md-8">
                @if(session()->has('error'))
                    <div class="alert alert-danger" role="alert">
                        {{session('error')}}
                    </div>
                @endif
                <div class="mar-ver pad-btm text-center">
                    <h1 class="h3 text-white">{{\App\CPU\translate('6POS Software Update')}}</h1>
                </div>
                <div class="card mt-3">
                    <div class="card-body">
                        <form method="POST" action="{{route('update-system')}}">
                            @csrf
                            <div class="form-group">
                                <label for="purchase_code" class="gap-2 mb-2">{{\App\CPU\translate('Codecanyon Username')}}</label>
                                <input type="text" class="form-control" id="username" value="{{env('BUYER_USERNAME')}}"
                                       name="username">
                            </div>

                            <div class="form-group">
                                <label for="purchase_code" class="gap-2 mb-2 mt-2">{{\App\CPU\translate('Purchase Code')}}</label>
                                <input type="text" class="form-control" id="purchase_key"
                                       value="{{env('PURCHASE_CODE')}}" name="purchase_key">
                            </div>
                            <div class="text-center mt-4">
                                <button type="submit" class="btn btn-info">{{\App\CPU\translate('Update')}}</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <div class="col-2"></div>
        </div>
    </div>
@endsection

