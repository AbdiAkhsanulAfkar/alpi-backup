<?php

class Model_siswa extends CI_model
{
    public function get()
    {
        return $this->db->get('siswa');
    }

    public function getAllSiswa()
    {
        return $this->db->get('siswa')->result_array();
    }

    public function getSiswaById($id)
    {
        return $this->db->get_where('siswa', ['nipd' => $id])->row_array();
    }
    public function searchSiswa()
    {
        $keyword = $this->input->post('keyword', true);
        $this->db->like('nipd', $keyword);
        $this->db->or_like('nama', $keyword);
        $this->db->or_like('kelas', $keyword);
        return $this->db->get('siswa')->result_array();
    }

    public function tambah($data)
    {
        return $this->db->insert('siswa', $data);
    }

    public function hapus($id)
    {
        $this->db->where('nipd', $id);
        $res = $this->db->delete('siswa');
        return $res;
    }

    public function ubah($id, $data)
    {
        $this->db->where('nipd', $id);
        return $this->db->update('siswa', $data);
    }

    // plot siswa

    public function getplotkelas($id)
    {
        // $this->db->where('id', $id);
        // return $this->db->get('bagi_kelas', $id);
        return $this->db->get_where('bagi_kelas', ['id' => $id])->result();
    }
    public function getsiswabelumplot()
    {
        return $this->db->get('siswa_belum_ploting_kelas');
    }
    public function getsiswabaru()
    {
        return $this->db->get('siswa_baru_belum_ploting_kelas');
    }
    public function simpanplotsiswa()
    {
        return $this->db->insert('siswa_belum_ploting_kelas');
    }
    public function simpanplotbaru($data)
    {
        return $this->db->insert('plot_kelas', $data);
    }

    // function rest api

    public function get_siswa()
    {
        $query = $this->db->get('siswa');
        return $query->result();
    }
    public function get_siswaa($id = null)
    {
        if ($id === null) {
            return $this->db->get_where('siswa', ['nipd' => $id])->result();
        } else {
            return $this->db->getWhere('siswa', ['nipd' => $id])->result();
        }
    }

    function cek_login($data)
    {
        $query = $this->db->get_where('siswa', $data);
        return $query;
    }

    function import()
    {
    }
}
