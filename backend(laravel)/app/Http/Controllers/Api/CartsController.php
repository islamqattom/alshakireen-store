<?php

namespace App\Http\Controllers\api;
use App\Models\item;
use App\Models\User;
use App\Http\Controllers\Controller;
use App\Models\Cart;
use App\Models\Images;
use Illuminate\Http\Request;
use App\Http\Helpers\ResponseBuilder;

class CartsController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $carts=Cart::All();

        foreach($carts as $cart){
            $item=Item::find($cart->item_id);
            if(!empty($item))
            {               
                $imagesGroup= Images::where('item_id',$cart->item_id)->first();
                $cart['item_name'] = $item->name;
                $cart['item_price'] = $item->price;
                $cart['item_image'] =explode(',',$imagesGroup['images'])[0];
            }
        }

        return ResponseBuilder::resultWithData((bool)$carts !=null,'successfully',$carts);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        
        $request->validate([
            'user_id'=>'required',
            'item_id'=>'required',
            'quantity'=>'required',
            'color'=>'required',
            'status'=>'required'
        ]);

        $current=Cart::where('user_id',$request->get('user_id'))->where('item_id',$request->get('item_id'))->where('status',0)->first();
        if($current!=null){
            $newCurrent=Cart::find($current->id);
            $newCurrent->quantity=$current->quantity + 1;

            return ResponseBuilder::result($newCurrent->save()?true:false,'added successfully');
        }

        $newCart=new Cart();
        $newCart->user_id=$request->get('user_id');
        $newCart->item_id=$request->get('item_id');
        $newCart->quantity=$request->get('quantity');
        $newCart->color=$request->get('color');
        $newCart->status=$request->get('status');

        return ResponseBuilder::result($newCart->save()?true:false,'added successfully');
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Cart  $cart
     * @return \Illuminate\Http\Response
     */
    public function show($userId)
    {
        $carts=Cart::where('user_id',$userId)->get();

        foreach($carts as $cart){
            $item=Item::find($cart->item_id);
            $imagesGroup= Images::where('item_id',$cart->item_id)->first();
            $cart['item_name']=$item->name;
            $cart['item_price']=$item->price * $cart->quantity;
            $cart['item_image']=explode(',',$imagesGroup['images'])[0];
        }

        return ResponseBuilder::resultWithData((bool)$carts!=null,'successfully',$carts);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\Cart  $cart
     * @return \Illuminate\Http\Response
     */
    public function edit(Cart $cart)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Cart  $cart
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Cart $cart)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Cart  $cart
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $destroy=Cart::destroy($id);
        return ResponseBuilder::result((bool)$destroy,'successfully');
    }

    public function soldItems()
    { 
        $carts=Cart::where('status','2')->limit(15)->inRandomOrder()->get();
        
        foreach($carts as $cart){
            $item=Item::find($cart->item_id);
            $imagesGroup= Images::where('item_id',$cart->item_id)->first();
            $cart['item_name']=$item->name;
            $cart['item_price']=$item->price;
            $cart['item_image']=explode(',',$imagesGroup['images'])[0];
        }

        return ResponseBuilder::resultWithData((bool)$carts != null,'successfully',$carts);

    }
    public function userItems($user_id)
    { 
        $carts=Cart::where('user_id',$user_id)->get();
        foreach($carts as $cart){
            $item=Item::find($cart->item_id);

            $cart['item_name']=$item->name;
            $cart['item_price']=$item->price;

            $image=Images::where('item_id',$cart->item_id)->first();
            $cart['item_image'] = explode(",", $image->images)[0];
        }

        return ResponseBuilder::resultWithData((bool)$carts != null,'successfully',$carts);

    }
    
    public function ItemUsers($item_id)
    { 
        $carts=Cart::where('item_id',$item_id)->get();
        foreach($carts as $cart){
            $user=User::find($cart->user_id);

            $cart['user_name']=$user->name;
            $cart['user_phone']=$user->phone;
            $cart['user_Email']=$user->email;
        }

        return ResponseBuilder::resultWithData((bool)$carts != null,'successfully',$carts);

    }
}
