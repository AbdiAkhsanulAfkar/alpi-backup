<div class="col-md">
            <div class="card">
                <div class="card-header text-center bg-primary text-white">
                    Tambah Data Soal
                </div>
                <div class="card-body">
                    <?= form_open_multipart('soal/insert'); ?>
                    <div class="form-group">
                        <label>Soal</label>
                        <input type="text" name="soal" required class="form-control">
                    </div>
                    <div class="form-group">
                        <label>Jawaban</label>
                        <input type="text" name="jawaban"  required class="form-control">
                    </div>
                    <div class="form-group">
                        <label>Kategori</label>
                        <input type="text" name="kategori"  required class="form-control">
                    </div> 
                    <button name="submit" class="btn btn-success"> Simpan</button>
                </div>
                <?= form_close(); ?>
            </div>
        </div>