<?php

class Model_soal extends CI_model
{
    public function get()
    {
        return $this->db->get('soal');
    }

    public function getAllSoal()
    {
        return $this->db->get('soal')->result_array();
    }

    public function getSoalById($id)
    {
        return $this->db->get_where('soal', ['id' => $id])->row_array();
    }
    public function searchSoal()
    {
        $keyword = $this->input->post('keyword', true);
        $this->db->like('soal', $keyword);
        $this->db->or_like('kategori', $keyword);
        return $this->db->get('soal')->result_array();
    }
    public function GetTable($tabel)
    {
        $data = $this->db->get($tabel);
        return $data->result_array();
    }

    public function tambah($data)
    {
        return $this->db->insert('soal', $data);
    }

    public function hapus($id)
    {
        $this->db->where('id', $id);
        $res = $this->db->delete('soal');
        return $res;
    }

    public function ubah($id, $data)
    {
        $this->db->where('id', $id);
        return $this->db->update('soal', $data);
    }
}
