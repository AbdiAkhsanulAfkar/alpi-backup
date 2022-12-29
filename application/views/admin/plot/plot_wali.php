<div class="card-body">
    <div>
        <a href="" class="btn btn-success" data-toggle="modal" data-target="#plot_wali">Plot Wali Kelas</a>
    </div>
    <div class="table-responsive mt-5">
        <div class="text-center">
            <span class="text-center">Wali Kelas Belum Plot</span>
            <table class=" table table-bordered mt-2">
                <thead>
                    <tr>
                        <th>No</th>
                        <th>NIP</th>
                        <th>Nama</th>
                    </tr>
                </thead>
                <tbody>
                    <?php $no = 1;
                    foreach ($plotwali as $d) : ?>
                        <tr>

                            <td><?= $no++ ?></td>
                            <td><?= $d->nip ?></td>
                            <td><?= $d->nama ?></td>
                        </tr>
                    <?php endforeach; ?>
                </tbody>
            </table>
        </div>
    </div>
    <div class="modal fade" id="plot_wali" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Import Data Siswa</h5>
                    <?php if ($this->session->flashdata('success')) { ?>
                        <p><?= $this->session->flashdata('success') ?></p>
                    <?php  } ?>
                    <?php if ($this->session->flashdata('error')) { ?>
                        <p><?= $this->session->flashdata('error') ?></p>
                    <?php  } ?>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <?= form_open_multipart('admin/simpanplotwalikelas'); ?>
                    <div class="modal-body">
                        <div class="input-group">
                            <select class="form-select" name="nipd_wali" id="nipd_wali">
                                <option value="">Pilih Guru</option>
                                <?php foreach ($plotwali as $d) : ?>
                                    <option value="<?php echo $d->nip;?>"><?php echo $d->nama;?></option>
                                <?php endforeach ?>
                            </select>
                        </div>
                        <div class="input-group" >
                            <select class="form-select mt-3" name="kelas_belum_plot" id="kelas_belum_plot">
                            <option value="">Pilih Kelas</option>
                                <?php foreach ($plotkelas as $d) : ?>
                                    <option value="<?php echo $d->id;?>"><?php echo $d->kelas;?></option>
                                <?php endforeach ?>
                            </select>
                        </div>
                        <div class="input-group" hidden>
                        <?php foreach ($tahun_akademik as $d) : ?>
                            <input type="text" class="form-control" id="tahun" name="tahun" value="<?php echo $d->id;?>">
                        <?php endforeach ?>    
                        </div>
                        <div class="input-group" hidden>
                        <?php foreach ($tahun_akademik as $d) : ?>
                            <input type="text" class="form-control" id="id_bagi_kelas1" name="id_bagi_kelas1" value="<?php echo substr($d->id, 1,2);?>">
                        <?php endforeach ?>
                        <div class="input-group" hidden>
                            <select class="form-select mt-3" name="id_bagi_kelas2" id="id_bagi_kelas2">
                                <option value=""></option>
                            </select>
                        </div>    
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Tutup</button>
                            <button type="submit" name="submit" class="btn btn-success"> <i class="fa fa-pencil"></i> Import Data</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>

</div>
</div>