<div class="card">
    <div class="card-header text-center bg-primary text-white">
        Tambah Data Absensi
    </div>
    <div class="card-body">
        <?= form_open_multipart('pelatih/tambah?pertemuan='.$data); ?>
        <?php foreach ($absensi as $d) : ?>
        <div class="form-group">
            <label>Nama</label>
            <input type="text" name="nama[]" required class="form-control" value="<?= $d->nama ?>">
            </select>
        </div>
        <div class="form-group">
            <label>Kelas</label>
            <input type="text" name="kelas[]" required class="form-control" value="<?= $d->kelas ?>">
        </div>
        <div class="form-group">
            <input type="text" name="pertemuan[]" required class="form-control" value="<?= $data ?>" hidden>
        </div>
        <div class="form-group">
            <label>Kehadiran</label>
            <select class="form-control" id="kehadiran" name="kehadiran[]">
                <option>Hadir</option>
                <option>Tidak Hadir</option>
            </select>
        </div>
        <div><hr color="black"></div>
        <?php endforeach; ?>
        <button name="submit" class="btn btn-success">Simpan</button>
    </div>
    <?= form_close(); ?>
</div>