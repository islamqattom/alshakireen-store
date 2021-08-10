<?php

namespace App\Http\Controllers\Api;
use App\Models\item;
use App\Http\Controllers\Controller;
use App\Models\User;
use App\Models\Cart;
use Illuminate\Http\Request;
use App\Http\Helpers\ResponseBuilder;

class UsersController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
       return ResponseBuilder::resultWithData(true,'successfully',User::all());
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
            'name'=>'required|min:3',
            'email'=>'required|email|unique:users',
            'phone'=>['required', 
                'min:10',
                'max:10',
                'unique:users',
                'regex:/^(078|077|079)[0-9]{7}$/'
            ],
            'password' => ['required', 
               'min:6', 
               'regex:/^.*(?=.{3,})(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[\d\x])(?=.*[!$#%]).*$/', 
            ]
        ]);

    try  { 
        
        $newUser = new User();
        $newUser->name=$request->get('name');
        $newUser->email=$request->get('email');
        $newUser->phone=$request->get('phone');
        $newUser->password=$request->get('password');

        return ResponseBuilder::result($newUser->save()?true:false,'added successfully');
  
    }catch(Exeption $e){
        return ResponseBuilder::result(false,'not success');
    }  

}

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\User  $user
     * @return \Illuminate\Http\Response
     */
    public function show(Request $request)
    {
        // phone, password
        $request->validate([
            'phone'=>'required',
            'password'=>'required',
        ]);

        $user = User::where('phone', $request->get('phone'))->where('password', $request->get('password'))->first();

        return ResponseBuilder::result((bool)$user !=null,$user);
        
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\User  $user
     * @return \Illuminate\Http\Response
     */
    public function edit(User $user)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\User  $user
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, User $user)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\User  $user
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $destroy=SubCategory::destroy($id);
        return ResponseBuilder::result((bool)$destroy,'successfully');
    }
    public function ItemUsers($userId)
    { 
        $Users=User::where('user_id',$userId)->get();
        foreach($Users as $User){
            $item=Item::find($User->userId);

            $User['item_name']=$item->name;
            $User['item_price']=$item->price;
            $User['item_image']=explode(",", $item->image)[0];
        }

        return ResponseBuilder::resultWithData((bool)$Users != null,'successfully',$Users);

    }
}
