<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Auth extends CI_Controller
{
    function __construct()
    {
        parent::__construct();
        $this->load->model('model_login');
    }
    public function index()
    {
        $this->load->view('auth/header');
        $this->load->view('auth/index');
        $this->load->view('auth/footer');
    }

    public function cek_login()
    {
        $data = array(
            'nip' => $this->input->post('nip', TRUE),
            'password' => md5($this->input->post('password', TRUE))
        );
        $this->load->model('Model_login'); // load model Login
        $hasil = $this->Model_login->cek_login($data);
        if ($hasil->num_rows() == 1) {

            foreach ($hasil->result() as $sess) {
                $sess_data['logged_in'] = 'Sudah Loggin';
                // $sess_data['id'] = $sess->id;
                $sess_data['nip'] = $sess->nip;
                $sess_data['level_id'] = $sess->level_id;
                // $sess_data['keahlian'] = $sess->keahlian;
                $this->session->set_userdata($sess_data);
            }
            if ($this->session->userdata('level_id') == '1') {
                redirect('admin');
            } elseif ($this->session->userdata('level_id') == '3') {
                redirect('pelatih');
            } else {
                echo "<script>alert('Gagal login: Cek username, password!');history.go(-1);</script>";
            }
        }
    }
    public function logout()
    {
        $this->session->unset_userdata('nip');
        $this->session->unset_userdata('level_id');
        session_destroy();
        redirect('auth');
    }
}
