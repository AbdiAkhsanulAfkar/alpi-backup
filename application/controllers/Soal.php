<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Soal extends CI_Controller
{
    function __construct()
    {
        parent::__construct();
        $this->load->model('Model_soal');
    }
    public function index()
    {
    
        $data['soal'] = $this->Model_soal->get()->result();
        $this->load->view('template/header');
        $this->load->view('template/sidebar');
        $this->load->view('template/topbar');
        $this->load->view('admin/soal', $data);
        $this->load->view('template/footer');
    }
    public function insert()
    {
            $soal = $this->input->post('soal');
            $jawaban = $this->input->post('jawaban');
            $kategori = $this->input->post('kategori');

            $data = array(
                'soal' => $soal,
                'jawaban' => $jawaban,
                'kategori' => $kategori
            ); //data yang akan di insert

            $this->Model_soal->tambah($data); //memasukan data melalui fungsi insertdata pad models mod.php

            redirect(base_url('soal')); //
        }
    

    public function hapus($id)
    {
        $this->Model_soal->hapus($id); //menghapus data
        redirect(base_url('soal')); //mengalihkan ke tampbali
    }

    public function ubah($id)
    {
        $data = array(
            'soal' => $this->input->post('soal'),
            'jawaban' => $this->input->post('jawaban'),
            'kategori' => $this->input->post('kategori'),
        );
        $this->Model_soal->ubah($id, $data);
        redirect(base_url('soal'));
    }
}
