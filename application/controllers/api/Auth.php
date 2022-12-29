<?php
defined('BASEPATH') or exit('No direct script access allowed');
require APPPATH . "libraries/Format.php";
require APPPATH . "libraries/RestController.php";

use chriskacerguis\RestServer\RestController;

class Auth extends RestController
{
    public function __construct()
    {
        parent::__construct();
        $this->load->model('Model_siswa');
    }
    public function index_get()
    {
        $sw = new Model_siswa;
        $resultsw = $sw->get_siswa();
        $this->response($resultsw, 200);
    }
    // public function SiswaById($id)
    // {
    //     $sw = new Model_siswa;
    //     $resultsw = $sw->get_siswaByID($id);
    //     $this->response($resultsw, 200);
    // }
}
