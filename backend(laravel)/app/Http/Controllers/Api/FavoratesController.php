<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Favorate;
use App\Models\User;
use App\Models\Item;
use App\Models\Images;
use Illuminate\Http\Request;
use App\Http\Helpers\ResponseBuilder;

class FavoratesController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return ResponseBuilder::resultWithData(true,'successfully',Favorate::all());
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
       $request ->validate([
          
           "user_id"=>'required',
           "item_id"=>'required'
       ]);

       $current=Favorate::where('user_id',$request->get('user_id'))->where('item_id',$request->get('item_id'))->first();
       if($current!=null){
           $destroy = Favorate::destroy($current->id);

           return ResponseBuilder::result($destroy?true:false,'added successfully');
       }

       $newFavorate=new Favorate();
       $newFavorate->user_id=$request->get('user_id');
       $newFavorate->item_id=$request->get('item_id');

       return ResponseBuilder::result($newFavorate->save()?true:false,'added successfully');
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Favorate  $favorate
     * @return \Illuminate\Http\Response
     */
    public function show($userId)
    {
        $favourites = Favorate::where('user_id',$userId)->get();  
        foreach($favourites as $favourite){
            $user=User::find($favourite->user_id);
            $favourite['user_name']=$user->name;

            $item=Item::find($favourite->item_id);
            $imagesGroup=Images::where('item_id',$item->id)->get();
            $favourite['item_name']=$item->name;
            $favourite['item_colors']=count($imagesGroup);
            $favourite['item_price']=$item->price;
            $favourite['item_image']=explode(",", $imagesGroup[0]['images'])[0];
           
        }

        return ResponseBuilder::resultWithData((bool)$favourites!=null,'successfully',$favourites);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\Favorate  $favorate
     * @return \Illuminate\Http\Response
     */
    public function edit(Favorate $favorate)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Favorate  $favorate
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Favorate $favorate)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Favorate  $favorate
     * @return \Illuminate\Http\Response
     */
    public function destroy(Favorate $favorate)
    {
        //
    }
}
