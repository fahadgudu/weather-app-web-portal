ActiveAdmin.register ProblemSolver do

  filter :problem
  filter :resolution

  permit_params :problem, :resolution,
    banner_attributes: [:id, :image]

    form do |f|
      f.inputs 'Details' do
        f.input :problem
        f.input :resolution
      end
      f.inputs :image,
        name: "Banner",
        for: [:banner, f.object.banner || Banner.new]
      f.actions
    end

end
