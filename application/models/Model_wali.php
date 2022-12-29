<?php

class Model_wali extends CI_model
{
    public function getgurubelumplot()
    {
        return $this->db->get('wali_kelas_bukan_tahun_ini');
    }

    public function getAllgurubelumplot()
    {
        return $this->db->get('wali_kelas_bukan_tahun_ini')->result_array();
    }

    public function getKelasBelumDiisi()
    {
        return $this->db->get('kelas_belum_ploting_walinya');
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

    public function simpanplotwalikelas($data)
    {
        return $this->db->insert('bagi_kelas', $data);
    }
}
