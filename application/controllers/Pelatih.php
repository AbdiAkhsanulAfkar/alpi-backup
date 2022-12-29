<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Pelatih extends CI_Controller
{
    function __construct()
    {
        parent::__construct();
        $this->load->model('Model_pelatih');
        if ($this->session->userdata('nip') == "") {
            redirect('auth');
        }
        $this->load->helper('text');
    }
    public function index()
    {
        $this->load->view('template/header');
        $this->load->view('template/sidebar_pelatih');
        $this->load->view('pelatih/classroom');
        $this->load->view('template/topbar');
        $this->load->view('template/footer');
    }
    public function profile()
    {
        $data['guru'] = $this->db->get_where('guru',);
        $this->load->view('template/header');
        $this->load->view('template/sidebar_pelatih');
        $this->load->view('template/topbar');
        $this->load->view('pelatih/edit_profile', $data);
        $this->load->view('template/footer');
    }
    public function edit()
    {
        // $data['title'] = 'Edit Profile';
        $data['guru'] = $this->db->get_where('guru', ['nip' => $this->session->userdata('nip')])->row_array();

        $this->form_validation->set_rules('nama', 'Full Name', 'required|trim');

        if ($this->form_validation->run() == false) {
            $this->load->view('template/header');
            $this->load->view('template/sidebar_pelatih');
            $this->load->view('template/topbar');
            $this->load->view('pelatih/edit_profile', $data);
            $this->load->view('template/footer');
        } else {
            $nama = $this->input->post('nama');
            $nip = $this->input->post('nip');

            // cek jika ada gambar yang akan diupload
            $upload_image = $_FILES['image']['name'];

            if ($upload_image) {
                $config['allowed_types'] = 'gif|jpg|png';
                $config['max_size']      = '2048';
                $config['upload_path'] = './assets/img/profile/';

                $this->load->library('upload', $config);

                if ($this->upload->do_upload('image')) {
                    $old_image = $data['user']['image'];
                    if ($old_image != 'default.jpg') {
                        unlink(FCPATH . 'assets/img/profile/' . $old_image);
                    }
                    $new_image = $this->upload->data('file_name');
                    $this->db->set('image', $new_image);
                } else {
                    echo $this->upload->dispay_errors();
                }
            }

            $this->db->set('nama', $nama);
            $this->db->where('nip', $nip);
            $this->db->update('guru');

            $this->session->set_flashdata('message', '<div class="alert alert-success" role="alert">Your profile has been updated!</div>');
            redirect('pelatih');
        }
    }

    public function admin()
    {
        $data['users'] = $this->Model_pelatih->get()->result();
        $this->load->view('template/header');
        $this->load->view('template/sidebar');
        $this->load->view('template/topbar');
        $this->load->view('admin/pelatih', $data);
        $this->load->view('template/footer');
    }

    public function insert()
    {
        // memasukan variable yang akan di inputkan

        $nip = $this->input->post('nip');
        $nama = $this->input->post('nama');
        $jk = $this->input->post('jk');
        $alamat = $this->input->post('alamat');
        $no_hp = $this->input->post('no_hp');
        $email = $this->input->post('email');
        $level_id = $this->input->post('level_id');
        // buat penampungan data berupa array 

        $data = array(
            'nip' => $nip,
            'nama' => $nama,
            'jk' => $jk,
            'alamat' => $alamat,
            'no_hp' => $no_hp,
            'email' => $email,
            'level_id' => $level_id
        ); //data yang akan di insert

        $this->Model_pelatih->tambah($data); //memasukan data melalui fungsi insertdata pad models mod.php

        redirect(base_url('pelatih/admin')); //
    }


    public function hapus($id)
    {
        $this->Model_pelatih->hapus($id); //menghapus data
        redirect(base_url('pelatih/admin')); //mengalihkan ke tampbali
    }
    public function hapusAkun($id)
    {
        $this->Model_pelatih->hapus($id); //menghapus data
        redirect(base_url('admin/akunPelatih')); //mengalihkan ke tampbali
    }

    public function ubah($id)
    {
        $data = array(
            'nip' => $this->input->post('nip'),
            'nama' => $this->input->post('nama'),
            'jk' => $this->input->post('jk'),
            'alamat' => $this->input->post('alamat'),
            'no_hp' => $this->input->post('no_hp'),
            'email' => $this->input->post('email'),
            // 'keahlian' => $this->input->post('keahlian')
        );
        $this->Model_pelatih->ubah($id, $data);
        redirect(base_url('pelatih/admin'));
    }
    public function ubahAkun($id)
    {
        $data = array(
            'nip' => $this->input->post('nip'),
            'passwrd' => $this->input->post('password')
        );
        $this->Model_pelatih->ubah($id, $data);
        redirect(base_url('admin/akunPelatih'));
    }

    public function absensi()
    {
        $data['pertemuan'] = $this->Model_pelatih->getPertemuan()->result();
        $this->load->view('template/header');
        $this->load->view('template/sidebar_pelatih');
        $this->load->view('template/topbar');
        $this->load->view('pelatih/pertemuan', $data);
        $this->load->view('template/footer');
    }

    public function data_absensi($id)
    {
        $data['absensi'] = $this->Model_pelatih->getWhere($id);
        $data['not_absen_yet'] = $this->Model_pelatih->getDataAbsen();
        $data_pertemuan = $this->input->get('pertemuan');
        $data['data'] = $data_pertemuan;
        $this->load->view('template/header');
        $this->load->view('template/sidebar_pelatih');
        $this->load->view('template/topbar');
        $this->load->view('pelatih/absensi', $data);
        $this->load->view('template/footer');
    }

    public function tambah_absensi()
    {
        $data['absensi'] = $this->Model_pelatih->getDataAbsen();
        $data_pertemuan = $this->input->get('pertemuan');
        $data['data'] = $data_pertemuan;
        $this->load->view('template/header');
        $this->load->view('template/sidebar_pelatih');
        $this->load->view('template/topbar');
        $this->load->view('pelatih/tambah_absensi', $data);
        $this->load->view('template/footer');
    }

    public function tambah()
    {
        $pert = $this->input->get('pertemuan');
        $nama = $this->input->post('nama');
        $kelas = $this->input->post('kelas');
        $pertemuan = $this->input->post('pertemuan');
        $kehadiran = $this->input->post('kehadiran');

        $data = array();
        $index = 0;
        foreach ($nama as $datanama) {
            array_push($data, array(
                'nama' => $datanama,
                'kelas' => $kelas[$index],
                'pertemuan' => $pertemuan[$index],
                'kehadiran' => $kehadiran[$index]
            ));
            $index++;
        }

        $this->Model_pelatih->tambahKehadiran($data);

        redirect(base_url('pelatih/data_absensi/' . $pert . '?pertemuan=' . $pert));
    }
}
