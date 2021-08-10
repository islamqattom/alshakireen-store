<?php

namespace App\Http\Controllers\Api;

use App\Models\User;
use App\Http\Controllers\Controller;
use App\Models\Comment;
use Illuminate\Http\Request;
use App\Http\Helpers\ResponseBuilder;

class CommentsController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return ResponseBuilder::resultWithData(true,'successfully',Comment::all());
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
            'comment'=>'required'
        ]);
        
        $newComment= new Comment();
        $newComment->user_id=$request->get('user_id');
        $newComment->item_id=$request->get('item_id');
        $newComment->comment=$request->get('comment');

        return ResponseBuilder::result($newComment->save()?true:false,'added successfully');

    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Comment  $comment
     * @return \Illuminate\Http\Response
     */
    public function show($itemId)
    {
        $comments = Comment::where('item_id',$itemId)->get();
        foreach($comments as $comment){
            $user=User::find($comment->user_id);
            $comment['user_name']=$user->name;   

        }
        return ResponseBuilder::resultWithData((bool)$comments!=null,'successfully',$comments);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\Comment  $comment
     * @return \Illuminate\Http\Response
     */
    public function edit(Comment $comment)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Comment  $comment
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Comment $comment)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Comment  $comment
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $destroy=Comment::destroy($id);
        return ResponseBuilder::result((bool)$destroy,'successfully');
    }
}
