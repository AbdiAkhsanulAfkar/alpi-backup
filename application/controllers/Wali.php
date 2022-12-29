<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Wali extends CI_Controller
{
    function __construct()
    {
        parent::__construct();
        $this->load->model('Model_siswa');
    }
    public function index()
    {
        $data['siswa'] = $this->Model_siswa->getAllSiswa();
        if ($this->input->post('keyword')) {
            $data['siswa'] = $this->Model_siswa->searchSiswa();
        }
        $this->load->view('template/header');
        $this->load->view('destinasi/index', $data);
        $this->load->view('template/footer');
    }
    // public function view($id)
    // {
    //     $data['destinasi'] = $this->Model_destinasi->getDestinasiById($id);
    //     $this->load->view('template/header');
    //     $this->load->view('destinasi/view', $data);
    //     $this->load->view('template/footer');
    // }
    // public function userView($id)
    // {
    //     $data['destinasi'] = $this->Model_destinasi->getDestinasiById($id);
    //     $this->load->view('template/header_user');
    //     $this->load->view('destinasi/view', $data);
    //     $this->load->view('template/footer');
    // }
    // public function user()
    // {
    //     $data['destinasi'] = $this->Model_destinasi->getAllDestinasi();
    //     if ($this->input->post('keyword')) {
    //         $data['destinasi'] = $this->Model_destinasi->searchDestinasi();
    //     }
    //     $this->load->view('template/header_user');
    //     $this->load->view('destinasi/index', $data);
    //     $this->load->view('template/footer');
    // }
    public function admin()
    {
        $data['siswa'] = $this->Model_siswa->get()->result();
        $this->load->view('template/header');
        $this->load->view('template/sidebar');
        $this->load->view('template/topbar');
        $this->load->view('admin/siswa', $data);
        $this->load->view('template/footer');
    }
    public function insert()
    {
        $nipd = $this->input->post('nipd');
        $nama = $this->input->post('nama');
        $nisn = $this->input->post('nisn');
        // $password = $this->input->post('password');
        $jk = $this->input->post('jk');
        // $kelas = $this->input->post('kelas');
        $jurusan_id = $this->input->post('jurusan_id');
        $no_hp = $this->input->post('no_hp');
        $email = $this->input->post('email');
        $alamat = $this->input->post('alamat');

        $data = array(
            'nipd' => $nipd,
            'nama' => $nama,
            'nisn' => $nisn,
            'jk' => $jk,
            // 'kelas' => $kelas,
            'jurusan_id' => $jurusan_id,
            'no_hp' => $no_hp,
            'email' => $email,
            'alamat' => $alamat
        ); //data yang akan di insert

        $this->Model_siswa->tambah($data); //memasukan data melalui fungsi insertdata pad models mod.php

        redirect(base_url('siswa/admin')); //
    }


    public function hapus($id)
    {
        $this->Model_siswa->hapus($id); //menghapus data
        redirect(base_url('siswa/admin')); //mengalihkan ke tampbali
    }
    public function hapusAkun($id)
    {
        $this->Model_siswa->hapus($id); //menghapus data
        redirect(base_url('admin/akunSiswa')); //mengalihkan ke tampbali
    }

    public function ubah($id)
    {
        $data = array(
            'nipd' => $this->input->post('nipd'),
            'nama' => $this->input->post('nama'),
            'nisn' => $this->input->post('nisn'),
            'jk' => $this->input->post('jk'),
            // 'kelas' => $this->input->post('kelas'),
            'jurusan_id' => $this->input->post('jurusan_id'),
            'no_hp' => $this->input->post('no_hp'),
            'email' => $this->input->post('email'),
            'alamat' => $this->input->post('alamat'),
        );
        $this->Model_siswa->ubah($id, $data);
        redirect(base_url('siswa/admin'));
    }
    public function ubahAkun($id)
    {
        $data = array(
            'nipd' => $this->input->post('nipd'),
            'password' => $this->input->post('password')
        );
        $this->Model_siswa->ubah($id, $data);
        redirect(base_url('admin/akunSiswa'));
    }
}
