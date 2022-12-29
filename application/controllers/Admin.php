<?php
defined('BASEPATH') or exit('No direct script access allowed');
class Admin extends CI_Controller
{
    function __construct()
    {
        parent::__construct();
        $this->load->model('Model_siswa');
        $this->load->model('Model_pelatih');
        $this->load->model('Model_wali');
        if ($this->session->userdata('nip') == "") {
            redirect('auth');
        }
        $this->load->helper('text');
    }
    public function index()
    {
        $data['nip'] = $this->session->userdata('nip');
        $this->load->view('template/header');
        $this->load->view('template/sidebar');
        $this->load->view('template/topbar');
        $this->load->view('template/footer');
    }
    public function siswa()
    {
        $data['username'] = $this->session->userdata('username');
        $this->load->view('template/header');
        $this->load->view('template/sidebar');
        $this->load->view('template/topbar');
        $this->load->view('admin/crud/tambah_siswa');
        $this->load->view('template/footer');
    }

    public function pelatih()
    {
        $data['username'] = $this->session->userdata('username');
        $this->load->view('template/header');
        $this->load->view('template/sidebar');
        $this->load->view('template/topbar');
        $this->load->view('admin/crud/tambah_pelatih');
        $this->load->view('template/footer');
    }
    public function soal()
    {
        $data['username'] = $this->session->userdata('username');
        $this->load->view('template/header');
        $this->load->view('template/sidebar');
        $this->load->view('template/topbar');
        $this->load->view('admin/crud/tambah_soal');
        $this->load->view('template/footer');
    }
    public function akunPelatih()
    {
        $data['username'] = $this->session->userdata('username');
        $data['users'] = $this->Model_pelatih->get()->result();
        $this->load->view('template/header');
        $this->load->view('template/sidebar');
        $this->load->view('template/topbar');
        $this->load->view('admin/pengguna/akun_pelatih', $data);
        $this->load->view('template/footer');
    }
    public function akunSiswa()
    {
        $data['nip'] = $this->session->userdata('nip');
        $data['siswa'] = $this->Model_siswa->get()->result();
        $this->load->view('template/header');
        $this->load->view('template/sidebar');
        $this->load->view('template/topbar');
        $this->load->view('admin/pengguna/akun_siswa', $data);
        $this->load->view('template/footer');
    }
    public function nilai()
    {
        // $data['username'] = $this->session->userdata('username');
        // $data['siswa'] = $this->Model_siswa->get()->result();
        $this->load->view('template/header');
        $this->load->view('template/sidebar');
        $this->load->view('template/topbar');
        $this->load->view('admin/saw/nilai');
        $this->load->view('template/footer');
    }
    public function Plotwali()
    {
        $date = substr(date("Y"), -2);
        $data['nip'] = $this->session->userdata('nip');
        $data['plotwali'] = $this->Model_wali->getgurubelumplot()->result();
        $data['plotkelas'] = $this->Model_wali->getKelasBelumDiisi()->result();
        $this->db->select('id');
        $this->db->from('tahun_akademik');
        $this->db->like('id', '22', 'after');
        $data['tahun_akademik']=$this->db->get()->result();
        // $data['plotsiswa'] = $this->Model_wali->getsiswabelumplot()->result();
        $this->load->view('template/header');
        $this->load->view('template/sidebar');
        $this->load->view('template/topbar');
        $this->load->view('admin/plot/plot_wali', $data);
        $this->load->view('template/footer');
        
    }

    public function getIdKelas()
    {
        $kelas_belum_plot = $this->input->post('kelas_belum_plot');
        $jurusan = $this->db->get_where('kelas_belum_ploting_walinya', ['id' => $kelas_belum_plot])->result();
        $output = '';
        foreach ($jurusan as $d) {
            $output .= '<option value="' . $d->id . '"> ' . $d->id . '</option>';
        }
        $this->output->set_content_type('application/json')->set_output(json_encode($output));
    }

    public function simpanplotwalikelas()
    {
        $id1 = $this->input->post('id_bagi_kelas1 ');
        $id2 = $this->input->post('id_bagi_kelas2 ');
        $id = $id1 ."". $id2;
        $data = array(
            'id' => $id,
            'guru_nip ' => $this->input->post('nipd_wali'),
            'tahun_akademik_id' => $this->input->post('tahun'),
            'kelas_id ' => $this->input->post('kelas_belum_plot'),
        );
        $this->Model_wali->simpanplotwalikelas($data);
        redirect(base_url('admin/Plotwali'));
    }

    public function Plotkelas()
    {
        $data['nip'] = $this->session->userdata('nip');
        $data['plotkelas'] = $this->Model_wali->getKelasBelumDiisi()->result();
        // $data['plotsiswa'] = $this->Model_wali->getsiswabelumplot()->result();
        $this->load->view('template/header');
        $this->load->view('template/sidebar');
        $this->load->view('template/topbar');
        $this->load->view('admin/plot/plot_wali', $data);
        $this->load->view('template/footer');
    }


    public function Plotsiswa()
    {
        $data['nip'] = $this->session->userdata('nip');
        $data['plotsiswa'] = $this->Model_siswa->getsiswabelumplot()->result();
        $this->load->view('template/header');
        $this->load->view('template/sidebar');
        $this->load->view('template/topbar');
        $this->load->view('admin/plot/plot_siswa', $data);
        $this->load->view('template/footer');
    }

    public function getKelasSiswaBelumPlot()
    {
        $nipd = $this->input->post('nipd_siswa_belum_plot');
        $jurusan = $this->db->get_where('siswa_belum_ploting_kelas', ['nipd' => $nipd])->result();
        foreach ($jurusan as $d) {
            $date = substr(date("Y"), -2);
            $this->db->select('bagi_kelas.id, kelas.kelas, jurusan.jurusan');
            $this->db->from('bagi_kelas');
            $this->db->join('kelas','bagi_kelas.kelas_id=kelas.id');
            $this->db->join('jurusan','kelas.jurusan_id=jurusan.id');
            $this->db->like('bagi_kelas.id', $date);
            $this->db->where("jurusan", $d->jurusan );
            $data=$this->db->get()->result();
            $output = '<option value="">Pilih Kelas</option>';
            foreach ($data as $row) {
                $output .= '<option value="' . $row->id . '"> ' . $row->kelas . '</option>';

        }
        
        }
        $this->output->set_content_type('application/json')->set_output(json_encode($output));
    }

    public function simpanSiswaBelumPlot(){
        $nipd = $this->input->post('nipd_siswa_belum_plot');
        $kelas = $this->input->post('kelas_siswa_belum_plot');

        $this->db->set('bagi_kelas_id', $kelas);
        $this->db->where('siswa_nipd', $nipd);
        $this->db->update('plot_kelas');
        
        redirect(base_url('admin/Plotsiswa'));
    
    }

    // public function getKelasSiswaBelumPlot()
    // {
    //     $nipd = $this->input->post('nipd_siswa_belum_plot');
    //     $this->db->select('jurusan, kelas_sebelumnya, LEFT(kelas_sebelumnya,char_length(kelas_sebelumnya)-2) as kelas');
    //     $this->db->where("nipd", $nipd );
    //     $this->db->from('siswa_belum_ploting_kelas');
    //     $jurusan=$this->db->get()->result();
    //     foreach ($jurusan as $d) {
    //         $date = substr(date("Y"), -2);
    //         $this->db->select('bagi_kelas.id, kelas.kelas, jurusan.jurusan');
    //         $this->db->from('bagi_kelas');
    //         $this->db->join('kelas','bagi_kelas.kelas_id=kelas.id');
    //         $this->db->join('jurusan','kelas.jurusan_id=jurusan.id');
    //         $this->db->like('bagi_kelas.id', $date);
    //         $this->db->not_like("kelas", $d->kelas );
    //         $this->db->where("jurusan", $d->jurusan );
    //         $data=$this->db->get()->result();
    //         $output = '<option value="">Pilih Kelas</option>';
    //         foreach ($data as $row) {
    //             $output .= '<option value="' . $row->id . '"> ' . $row->kelas . '</option>';

    //     }
        
    //     }
    //     $this->output->set_content_type('application/json')->set_output(json_encode($output));
    // }
    
    public function Plotsiswabaru()
    {
        $data['nip'] = $this->session->userdata('nip');
        $data['plotsiswabaru'] = $this->Model_siswa->getsiswabaru()->result();
        $this->load->view('template/header');
        $this->load->view('template/sidebar');
        $this->load->view('template/topbar');
        $this->load->view('admin/plot/plot_siswa_baru', $data);
        $this->load->view('template/footer');
    }

    public function getKelasSiswaBaruBelumPlot()
    {
        $nipd = $this->input->post('nipd');
        $jurusan = $this->db->get_where('siswa_baru_belum_ploting_kelas', ['nipd' => $nipd])->result();
        foreach ($jurusan as $d) {
            $date = substr(date("Y"), -2);
            $this->db->select('bagi_kelas.id, kelas.kelas, jurusan.jurusan');
            $this->db->from('bagi_kelas');
            $this->db->join('kelas','bagi_kelas.kelas_id=kelas.id');
            $this->db->join('jurusan','kelas.jurusan_id=jurusan.id');
            $this->db->like('bagi_kelas.id', $date);
            $this->db->where("jurusan", $d->jurusan );
            $data=$this->db->get()->result();
            $output = '<option value="">Pilih Kelas</option>';
            foreach ($data as $row) {
                $output .= '<option value="' . $row->id . '"> ' . $row->kelas . '</option>';

        }
        
        }
        $this->output->set_content_type('application/json')->set_output(json_encode($output));
    }

    public function simpanplotbaru()
    {
        $data = array(
            'siswa_nipd' => $this->input->post('nipd'),
            'bagi_kelas_id' => $this->input->post('kelas'),
        );
        $this->Model_siswa->simpanplotbaru($data);
        redirect(base_url('admin/Plotsiswabaru'));
    }
}
