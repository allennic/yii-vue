<?php
/**
 * Created by PhpStorm.
 * User: erb398wei
 * Date: 2017/2/26
 * Time: 15:12
 */

namespace app\controllers;

use app\m\News;
use yii\rest\ActiveController;

use yii\web\Response;


class UserController extends ActiveController
{
    public $modelClass = 'app\m\Users';

    public function behaviors()
    {
        $behaviors = parent::behaviors();
        $behaviors['contentNegotiator']['formats']['text/html'] = Response::FORMAT_JSON;
        return $behaviors;
    }

    /* function actions()
     {
         $action= parent::actions(); //
         unset($action["index"]);
     }

     public  function actionIndex()
     {
         echo "shenyi";
     }*/

    public function init(){

        $this->enableCsrfValidation = false;
    }
    public function actionDo(){
        //echo "aaa";

        $news=new News();
//        $news->news_title="baoxun";
//        $news->news_classid=3;
//        $news->user_id=2;
//        $news->save();
//        var_export($news::find()->where()->orderBy()->all());

        //$news::find()->joinWith("newsClass")->all()[1]->news_title;

        //var_export($news::find()->joinWith("newsClass")->all()[1]->newsClass->class_name);

        //$news::find()->joinWith("newsClass")->createCommand()->getSql();


    }
}