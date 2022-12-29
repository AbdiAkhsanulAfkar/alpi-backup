<?php

class Model_pelatih extends CI_model
{
    public function get()
    {
        return $this->db->get('guru');
    }

    public function getAllPelatih()
    {
        return $this->db->get('guru')->result_array();
    }

    public function getPelatihById($id)
    {
        return $this->db->get_where('guru', ['nip' => $id])->row_array();
    }
    public function searchPelatih()
    {
        $keyword = $this->input->post('keyword', true);
        $this->db->like('nip', $keyword);
        $this->db->or_like('nama', $keyword);
        return $this->db->get('guru')->result_array();
    }

    public function GetTable($tabel)
    {
        $data = $this->db->get($tabel);
        return $data->result_array();
    }

    public function tambah($data)
    {
        return $this->db->insert('guru', $data);
    }

    public function hapus($id)
    {
        $this->db->where('nip', $id);
        $res = $this->db->delete('guru');
        return $res;
    }

    public function ubah($id, $data)
    {
        $this->db->where('nip', $id);
        return $this->db->update('guru', $data);
    }

    public function getPertemuan()
    {
        return $this->db->get('pertemuan');
    }

    public function tambahKehadiran($data)
    {
        return $this->db->insert_batch('absensi', $data);
    }

    public function getPerPertemuan($id)
    {
        return $this->db->get_where('absensi', array('pertemuan' => $id))->result();
    }

    public function getWhere($id)
    {
        $name = $this->session->userdata('keahlian');
        $this->db->select('siswa.nama, siswa.kelas, absensi.pertemuan, absensi.kehadiran');
        $this->db->from('siswa');
        $this->db->join('absensi', 'siswa.nama=absensi.nama');
        $this->db->where('absensi.pertemuan', $id);
        $this->db->like('absensi.kelas', $name);
        return $this->db->get()->result();
    }

    public function getDataAbsen()
    {
        $name = $this->session->userdata('keahlian');
        $this->db->select('nama, kelas');
        $this->db->from('siswa');
        $this->db->like('kelas', $name);
        return $this->db->get()->result();
    }

    public function getInsertAbsen()
    {
        $name = $this->session->userdata('keahlian');
        $this->db->select('siswa.nama, siswa.kelas, absensi.pertemuan, absensi.kehadiran');
        $this->db->from('siswa');
        $this->db->join('absensi', 'siswa.nama=absensi.nama');
        $this->db->like('absensi.kelas', $name);
        return $this->db->get()->result();
    }


    // function rest api

    public function get_pelatih()
    {
        $query = $this->db->get('siswa');
        return $query->result();
    }
}
